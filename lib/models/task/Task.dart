import 'dart:io';

import 'package:app/models/song/Song.dart';
import 'package:app/services/device_identifier.dart';
import 'package:app/utils/secure_random.dart';
import 'package:app/utils/task_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

part 'Task.freezed.dart';

part 'Task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required TaskStatus status,
    required String bucket,
    @Default([]) List<Song> songs,
    @JsonKey(name: "created_by") required String createdBy,
    @JsonKey(name: "created_on") required int createdOn,
    @JsonKey(name: "file_upload_path") String? fileUploadPath,
    @JsonKey(name: "image_url")
    String? imageUrl,
    @JsonKey(includeFromJson: false, includeToJson: false) String? localFilePath,
    @JsonKey(includeFromJson: false, includeToJson: false) String? downloadedFilePath,
  }) = _Task;

  const Task._();

  bool get isEmpty => id.isEmpty;

  bool get isComplete => status != TaskStatus.initial && status == TaskStatus.complete;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.empty() => Task(
        id: getRecordId(),
        status: TaskStatus.initial,
        bucket: '',
        createdBy: Get.find<DeviceIdentifier>().deviceId,
        createdOn: DateTime.now().millisecondsSinceEpoch,
      );
}
