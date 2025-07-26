import 'package:app/ui/search/widgets/seekbar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerListTileProps {
  final AudioPlayer? audioPlayer;
  final String? id;

  PlayerState playerState = PlayerState(false, ProcessingState.idle);

  AudioPlayerListTileProps({this.audioPlayer, this.id});

  AudioPlayerListTileProps copyWith({AudioPlayer? audioPlayer, String? id}) {
    return AudioPlayerListTileProps(
      audioPlayer: audioPlayer,
      id: id,
    );
  }

  Future<AudioPlayerListTileProps> disposePlayer(String songId) async {
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

  Future<AudioPlayerListTileProps> initPlayer({
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
