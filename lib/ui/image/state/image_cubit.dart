import 'dart:io';

import 'package:app/models/task/Task.dart';
import 'package:app/route_generator.dart';
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
  ImageCubit() : super(ImageState(selectedTask: Task.empty()));

  void onFileChange(File? file) {
    if (file == null) return;

    emit(state.copyWith(
      selectedTask: state.selectedTask.copyWith(
        file: file,
        imageUrl: file.path,
      ),
    ));
  }

  void onImageTap(String url) {
    emit(
      state.copyWith(
        selectedTask: state.selectedTask.copyWith(
          imageUrl: url,
          file: null,
        ),
      ),
    );

    RouteGenerator.rootNavigatorKey.currentContext!
        .push(Routes.VIEW_IMAGE.value);
  }

  void onSelectFileButtonPressed() async {
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

  void onUploadFileButtonPressed() async {
    // can't upload if not a local image
    if (!state.selectedTask.isLocalImage) return;

    // init services
    final storageService = Get.find<StorageService>();
    final dbService = Get.find<DbService>();

    // emit uploading process state
    emit(
      state.copyWith(
        selectedTask: state.selectedTask.copyWith(status: TaskStatus.uploading),
      ),
    );

    // upload picture
    final file = File(state.selectedTask.imageUrl);

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
    emit(
      state.copyWith(
        selectedTask: state.selectedTask.copyWith(
          status: TaskStatus.processing,
          bucket: response.bucket,
          fileUploadPath: uploadPath,
          imageUrl: response.downloadUrl,
          createdOn: DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );

    // create task within firestore
    try {
      await dbService.createTask(state.selectedTask);
    } catch (e) {
      print(e);
    }

    // add the task on home page
    RouteGenerator.homeCubit.addTask(state.selectedTask);

    // extract songs
    try {
      await dbService.extractSongs(state.selectedTask.id);
    } catch (e) {
      print(e);
    }

    // fetch the added songs
    Task updatedTask = await dbService.getTask(state.selectedTask.id);

    // emit the new updated task with the songs data
    emit(state.copyWith(selectedTask: updatedTask));
  }

  void makeTestFirestoreRecord() {
    Get.find<DbService>().makeTestFirestoreRecord();
  }
}
