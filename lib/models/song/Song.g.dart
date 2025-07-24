// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SongImpl _$$SongImplFromJson(Map<String, dynamic> json) => _$SongImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      artistName: json['artist_name'] as String,
      image: json['image'] as String,
      previewUrl: json['preview_url'] as String,
      mood: $enumDecode(_$MoodEnumMap, json['mood']),
      genre: $enumDecode(_$GenreEnumMap, json['genre']),
      addedOn: (json['added_on'] as num).toInt(),
    );

Map<String, dynamic> _$$SongImplToJson(_$SongImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist_name': instance.artistName,
      'image': instance.image,
      'preview_url': instance.previewUrl,
      'mood': _$MoodEnumMap[instance.mood]!,
      'genre': _$GenreEnumMap[instance.genre]!,
      'added_on': instance.addedOn,
    };

const _$MoodEnumMap = {
  Mood.happy: 'happy',
  Mood.sad: 'sad',
  Mood.excited: 'excited',
  Mood.relaxed: 'relaxed',
  Mood.nostalgic: 'nostalgic',
  Mood.adventurous: 'adventurous',
  Mood.romantic: 'romantic',
  Mood.angry: 'angry',
  Mood.surprised: 'surprised',
  Mood.peaceful: 'peaceful',
};

const _$GenreEnumMap = {
  Genre.pop: 'pop',
  Genre.rock: 'rock',
  Genre.hiphop: 'hiphop',
  Genre.jazz: 'jazz',
  Genre.classical: 'classical',
  Genre.electronic: 'electronic',
  Genre.country: 'country',
  Genre.reggae: 'reggae',
};
