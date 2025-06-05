import 'package:app/models/song/Song.dart';
import 'package:app/ui/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

class AudioPlayerView extends StatefulWidget {
  final Song song;

  const AudioPlayerView({
    super.key,
    required this.song,
  });

  @override
  State<AudioPlayerView> createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  late AudioPlayer player;

  ValueNotifier<PlayerState> playerStateNotifier = ValueNotifier<PlayerState>(
    PlayerState(false, ProcessingState.idle),
  );

  @override
  void initState() {
    super.initState();

    initPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void initPlayer() async {
    // initializing the player
    try {
      player = AudioPlayer();
      player.setVolume(1);
      player.setLoopMode(LoopMode.all);
      await player.setUrl(widget.song.previewUrl);
    } catch (e) {
      // Fallback for all other errors
      Get.find<Logger>().e("Error: $e");
    }

    // listening for player stream
    player.playerStateStream.listen((state) {
      if (!playerStateNotifier.value.playing &&
          state.processingState == ProcessingState.ready) {
        player.play();
      }
      playerStateNotifier.value = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CachedImage(
            widget.song.image,
            radius: 100,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.song.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.song.artistName,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              if (playerStateNotifier.value.playing) {
                player.pause();
              } else {
                player.play();
              }
            },
            child: ValueListenableBuilder(
              valueListenable: playerStateNotifier,
              builder: (context, state, child) {
                return Icon(
                  state.playing
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 45,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
