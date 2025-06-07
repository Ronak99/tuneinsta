// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SongImpl _$$SongImplFromJson(Map<String, dynamic> json) => _$SongImpl(
      title: json['title'] as String,
      artistName: json['artist_name'] as String,
      image: json['image'] as String,
      previewUrl: json['preview_url'] as String,
    );

Map<String, dynamic> _$$SongImplToJson(_$SongImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'artist_name': instance.artistName,
      'image': instance.image,
      'preview_url': instance.previewUrl,
    };
