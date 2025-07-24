part of 'search_cubit.dart';

class SearchState {
  final bool isLoading;
  final List<Song> results;

  SearchState({
    this.isLoading = false,
    this.results = const [],
  });

  SearchState copyWith({
    bool? isLoading,
    List<Song>? results,
}) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
    );
  }
}
