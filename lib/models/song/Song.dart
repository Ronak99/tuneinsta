import 'package:freezed_annotation/freezed_annotation.dart';

part 'Song.freezed.dart';

part 'Song.g.dart';

@freezed
class Song with _$Song {
  const factory Song({
    required String title,
    @JsonKey(name: "artist_name") required String artistName,
    required String image,
    @JsonKey(name: "preview_url") required String previewUrl,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}
