import 'package:app/models/task/Task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_state.freezed.dart';

@freezed
class ImageState with _$ImageState {
  factory ImageState ({
    required Task selectedTask,
  }) = _ImageState;
}