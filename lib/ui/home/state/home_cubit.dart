import 'dart:async';

import 'package:app/models/task/Task.dart';
import 'package:app/services/db_service.dart';
import 'package:app/services/device_identifier.dart';
import 'package:app/ui/home/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeCubit extends Cubit<HomeState> {
  // top-level streams
  StreamSubscription<List<Task>>? taskStream;

  HomeCubit() : super(const HomeState()) {
    initialize();
  }

  void initialize() async {
    String deviceId = Get.find<DeviceIdentifier>().deviceId;

    taskStream = Get.find<DbService>().streamTasks(deviceId).listen((tasks) {
      emit(state.copyWith(tasks: tasks));
    });
  }
}
