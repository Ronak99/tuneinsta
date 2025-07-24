import 'package:freezed_annotation/freezed_annotation.dart';

part 'Song.freezed.dart';

part 'Song.g.dart';

enum Mood {
  happy,
  sad,
  excited,
  relaxed,
  nostalgic,
  adventurous,
  romantic,
  angry,
  surprised,
  peaceful,
}

enum Genre {
  pop,
  rock,
  hiphop,
  jazz,
  classical,
  electronic,
  country,
  reggae,
}

@freezed
class Song with _$Song {
  const factory Song({
    required String id,
    required String title,
    @JsonKey(name: "artist_name") required String artistName,
    required String image,
    @JsonKey(name: "preview_url") required String previewUrl,
    required Mood mood,
    required Genre genre,
    @JsonKey(name: "added_on") required int addedOn,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}
