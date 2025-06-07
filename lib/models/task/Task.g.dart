// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      bucket: json['bucket'] as String,
      songs: (json['songs'] as List<dynamic>?)
              ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdBy: json['created_by'] as String,
      createdOn: (json['created_on'] as num).toInt(),
      fileUploadPath: json['file_upload_path'] as String?,
      imageUrl:
          json['image_url'] as String? ?? "https://i.sstatic.net/y9DpT.jpg",
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'bucket': instance.bucket,
      'songs': instance.songs,
      'created_by': instance.createdBy,
      'created_on': instance.createdOn,
      'file_upload_path': instance.fileUploadPath,
      'image_url': instance.imageUrl,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.initial: 'initial',
  TaskStatus.uploading: 'uploading',
  TaskStatus.processing: 'processing',
  TaskStatus.complete: 'complete',
  TaskStatus.error: 'error',
  TaskStatus.curating: 'curating',
};
