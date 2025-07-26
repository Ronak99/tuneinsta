import 'package:app/models/song/Song.dart';
import 'package:app/ui/search/search_cubit.dart';
import 'package:app/ui/search/widgets/search_list_item.dart';
import 'package:app/ui/search/widgets/seekbar.dart';
import 'package:app/ui/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerCollection {
  final AudioPlayer? audioPlayer;
  final String? id;

  PlayerState playerState = PlayerState(false, ProcessingState.idle);

  AudioPlayerCollection({this.audioPlayer, this.id});

  AudioPlayerCollection copyWith({AudioPlayer? audioPlayer, String? id}) {
    return AudioPlayerCollection(
      audioPlayer: audioPlayer,
      id: id,
    );
  }

  Future<AudioPlayerCollection> disposePlayer(String songId) async {
    await audioPlayer?.pause();
    await audioPlayer?.dispose();
    return copyWith(audioPlayer: null, id: songId);
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer!.positionStream,
          audioPlayer!.bufferedPositionStream,
          audioPlayer!.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  Future<AudioPlayerCollection> initPlayer({
    required String url,
    required String songId,
  }) async {
    // initialize a new instance of it
    final audioPlayer = AudioPlayer();
    audioPlayer.setVolume(1);
    audioPlayer.setLoopMode(LoopMode.off);
    await audioPlayer.setUrl(url);

    // retrieve a state stream
    audioPlayer.playerStateStream.listen((state) {
      if (!playerState.playing &&
          state.processingState == ProcessingState.ready) {
        audioPlayer.play();
      }
      playerState = state;
    });

    return copyWith(audioPlayer: audioPlayer, id: songId);
  }

  Future<void> togglePlayPause() async {
    if (audioPlayer == null) return;
    if (audioPlayer!.playing) {
      await audioPlayer!.pause();
    } else {
      await audioPlayer!.play();
    }
  }
}

class SearchTrackPage extends StatelessWidget {
  final ValueNotifier<AudioPlayerCollection> audioPlayerNotifier =
      ValueNotifier(AudioPlayerCollection());

  SearchTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return CustomScaffold(
      title: "Search Track",
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TextField(
          onChanged: searchCubit.onSearchValueChange,
          decoration: const InputDecoration(
            hintText: "Write the name of the song or the artist.",
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        alignment: Alignment.center,
        child: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator();
          }
          if (state.results.isEmpty) {
            return const Text("No Songs");
          }
          return ListView.separated(
            padding: const EdgeInsets.only(top: 16),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              Song song = state.results[index];
              return SearchListItem(
                audioPlayerNotifier: audioPlayerNotifier,
                song: song,
              );
            },
          );
        }),
      ),
    );
  }
}
