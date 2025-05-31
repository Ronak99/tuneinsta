import 'package:app/models/task/Task.dart';
import 'package:app/services/db_service.dart';
import 'package:app/services/device_identifier.dart';
import 'package:app/ui/home/widgets/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    initialize();
  }

  void initialize() async {
    emit(state.copyWith(isLoading: true));

    String deviceId = Get.find<DeviceIdentifier>().deviceId;
    List<Task> tasks = (await Get.find<DbService>().getTasks(deviceId))
        .docs
        .map((e) => e.data())
        .toList();

    emit(state.copyWith(tasks: tasks, isLoading: false));
  }

  void addTask(Task task) {
    List<Task> tasks = List.from(state.tasks);
    tasks.add(task);
    emit(state.copyWith(tasks: tasks));
  }
}
