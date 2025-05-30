import 'dart:io';

enum ProcessState {
  // default state for initializing
  initial,

  // picture has started uploading
  uploading,

  // picture has uploaded, so the processing has begun
  processing,

  // songs have been populated
  complete,
}

class HomeState {
  File? selectedFile;
  String? selectedImage;
  ProcessState processState;
  String? taskId;

  HomeState({
    this.selectedFile,
    this.selectedImage,
    this.taskId,
    this.processState = ProcessState.initial,
  });

  HomeState copyWith({
    File? selectedFile,
    String? selectedImage,
    String? taskId,
    ProcessState? processState,
  }) {
    return HomeState(
      selectedFile: selectedFile ?? this.selectedFile,
      selectedImage: selectedImage ?? this.selectedImage,
      processState: processState ?? this.processState,
      taskId: taskId ?? this.taskId,
    );
  }
}