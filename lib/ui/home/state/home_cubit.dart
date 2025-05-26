import 'dart:io';

import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void onFileChange(File? file) {
    emit(state.copyWith(selectedFile: file));
  }

  void onSelectFileButtonPressed() async {
    // check for permissions
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      RouteGenerator.homeCubit.onFileChange(file);
    } else {
      // User canceled the picker
      Get.find<Logger>().e("No file was selected by the user.");
    }
  }

  void onUploadFileButtonPressed() async {
    final storageService = Get.find<StorageService>();
    final dbService = Get.find<DbService>();

    final file = state.selectedFile!;

    final fileNameWithExt = file.uri.pathSegments.last;
    const String folder = "uploads";
    const String mimeType = "image/jpeg";
    String uploadPath = "$folder/$fileNameWithExt";

    // emit uploading process state
    emit(state.copyWith(processState: ProcessState.uploading));

    String taskId = await dbService.createTask(
      fileName: fileNameWithExt,
      uploadPath: uploadPath,
      mimeType: mimeType,
    );

    // set the taskId
    emit(state.copyWith(taskId: taskId));

    // upload picture
    String? downloadUrl = await storageService.uploadPicture(
      file: file,
      uploadPath: uploadPath,
      mimeType: mimeType,
      taskId: taskId,
    );

    // image has been uploaded
    emit(state.copyWith(processState: ProcessState.processing));

    Get.find<Logger>().i("Download URL: $downloadUrl");
  }

  void makeTestFirestoreRecord() {
    Get.find<DbService>().makeTestFirestoreRecord();
  }
}
