import 'package:app/models/song/Song.dart';
import 'package:app/services/search_track_service.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/secure_random.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  void onSearchValueChange(String text) {
    EasyDebounce.debounce('tag', const Duration(milliseconds: 300), () {
      searchSongs(text);
    });
  }

  void searchSongs(String query) async {
    try {
      emit(state.copyWith(isLoading: true));

      SearchResponse searchResponse =
          await Get.find<SearchTrackService>().searchTracks(query);

      List<Song> songs = searchResponse.results
          .map(
            (track) => Song(
              id: getRecordId(),
              title: track.trackName,
              artistName: track.artistName,
              image: track.artworkUrl100,
              previewUrl: track.previewUrl,
              genre: [Genre.classical],
              mood: [Mood.adventurous],
              addedOn: DateTime.now().millisecondsSinceEpoch,
            ),
          )
          .toList();

      emit(state.copyWith(isLoading: false, results: songs));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Error occurred: ${query}");
    }
  }
}
