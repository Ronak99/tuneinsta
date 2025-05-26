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
  ProcessState processState;
  String? taskId;

  HomeState({
    this.selectedFile,
    this.taskId,
    this.processState = ProcessState.initial,
  });

  HomeState copyWith({
    File? selectedFile,
    String? taskId,
    ProcessState? processState,
  }) {
    return HomeState(
      selectedFile: selectedFile ?? this.selectedFile,
      processState: processState ?? this.processState,
      taskId: taskId ?? this.taskId,
    );
  }
}
