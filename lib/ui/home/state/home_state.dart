import 'package:app/models/task/Task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';
@freezed

class HomeState with _$HomeState {
  const factory HomeState ({
    @Default([]) List<Task> tasks,
    @Default(false) bool isLoading,
    @Default(false) bool isPaginating,
  }) = _HomeState;
}