import 'dart:async';
import 'dart:io';

import 'package:app/models/share/AppShare.dart';
import 'package:app/models/task/Task.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/share_service.dart';
import 'package:app/services/db_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/ui/image/state/image_state.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/task_status.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart';

class ImageCubit extends Cubit<ImageState> {
  // top-level stream
  StreamSubscription<Task>? taskStream;

  ImageCubit() : super(ImageState(selectedTask: Task.empty()));

  void initializeStream() {
    // cancel any ongoing stream
    taskStream?.cancel();

    // initialize a new stream if it exists
    taskStream =
        Get.find<DbService>().streamTask(state.selectedTask.id).listen((task) {
      emit(state.copyWith(selectedTask: task));
      if (task.status == TaskStatus.complete) {
        downloadImageAndNotify();
      }
    });
  }

  void onFileChange(File? file) {
    if (file == null) return;

    emit(state.copyWith(selectedTask: Task.empty()));

    emit(state.copyWith(
      selectedTask: state.selectedTask.copyWith(localFilePath: file.path),
    ));
  }

  void onTaskTap(Task task) {
    emit(state.copyWith(selectedTask: task));

    RouteGenerator.rootNavigatorKey.currentContext!
        .push(Routes.VIEW_IMAGE.value);
  }

  void onShareButtonTap({required AppShare appShare}) async {
    if (state.selectedTask.downloadedFilePath == null) return;

    Get.find<ShareService>().share(
      appShare,
      filePath: state.selectedTask.downloadedFilePath!,
    );
  }

  void onSelectFileButtonPressed() async {
    // when user taps upload button, even though an empty task is available
    // it means that the image is being uploaded and the record has not been created.
    if (state.selectedTask.status == TaskStatus.uploading) {
      Get.find<Logger>().e("Image is being uploaded, please wait...");
      return;
    }

    // check for permissions
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      onFileChange(file);

      RouteGenerator.rootNavigatorKey.currentContext!
          .push(Routes.VIEW_IMAGE.value);
    } else {
      // User canceled the picker
      Get.find<Logger>().e("No file was selected by the user.");
    }
  }

  void downloadImageAndNotify() async {
    final storageService = Get.find<StorageService>();
    // download this image and set the downloaded value to localFilePath
    String downloadedFilePath = await storageService.downloadImage(
      url: state.selectedTask.imageUrl!,
      name: state.selectedTask.fileUploadPath!.split("/").last,
    );

    Task updatedTask =
        state.selectedTask.copyWith(downloadedFilePath: downloadedFilePath);

    await Future.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(selectedTask: updatedTask));
  }

  void onImageViewInit() async {
    initializeStream();

    try {
      if (state.selectedTask.localFilePath == null) {
        return;
      }

      // init services
      final dbService = Get.find<DbService>();
      final storageService = Get.find<StorageService>();

      // emit uploading process state
      emit(
        state.copyWith(
          selectedTask:
              state.selectedTask.copyWith(status: TaskStatus.uploading),
        ),
      );

      // upload picture
      final file = File(state.selectedTask.localFilePath!);

      final fileNameWithExt = file.uri.pathSegments.last;
      const String folder = "uploads";
      const String mimeType = "image/jpeg";
      String uploadPath = "$folder/$fileNameWithExt";

      UploadResponse? response = await storageService.uploadPicture(
        file: file,
        uploadPath: uploadPath,
        mimeType: mimeType,
      );

      // update a few aspects of the task that are now known.
      final updatedTask = state.selectedTask.copyWith(
        status: TaskStatus.processing,
        bucket: response.bucket,
        fileUploadPath: uploadPath,
        imageUrl: response.downloadUrl,
        createdOn: DateTime.now().millisecondsSinceEpoch,
      );

      await dbService.createTask(updatedTask);
      emit(state.copyWith(selectedTask: updatedTask));
      initializeStream();

      // extract songs
      await dbService.extractSongs(state.selectedTask.id);
    } catch (e) {
      Get.find<Logger>().e("onImageViewInit: $e");
    }
  }
}
