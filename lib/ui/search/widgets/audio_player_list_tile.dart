import 'package:app/models/audio_player_tile/audio_player_list_tile_props.dart';
import 'package:app/models/song/Song.dart';
import 'package:app/ui/add/master.dart';
import 'package:app/ui/search/master.dart';
import 'package:app/ui/search/widgets/seekbar.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerListTile extends StatefulWidget {
  final Song song;
  final Widget? trailing;
  final ValueNotifier<AudioPlayerListTileProps> audioPlayerListTileProps;

  const AudioPlayerListTile({
    super.key,
    required this.song,
    this.trailing,
    required this.audioPlayerListTileProps,
  });

  @override
  State<AudioPlayerListTile> createState() => _AudioPlayerListTileState();
}

class _AudioPlayerListTileState extends State<AudioPlayerListTile> {
  @override
  void dispose() {
    disposePlayer();
    super.dispose();
  }

  void disposePlayer() {
    if (widget.audioPlayerListTileProps.value.id == widget.song.id) {
      widget.audioPlayerListTileProps.value.disposePlayer(widget.song.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: double.infinity,
      child: Stack(
        children: [
          ValueListenableBuilder<AudioPlayerListTileProps>(
            valueListenable: widget.audioPlayerListTileProps,
            builder: (context, audioPlayerCollection, child) {
              if (audioPlayerCollection.id == widget.song.id &&
                  audioPlayerCollection.audioPlayer != null) {
                return StreamBuilder<PositionData>(
                  stream:
                      widget.audioPlayerListTileProps.value.positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return SeekBar(
                      duration: positionData?.duration ?? Duration.zero,
                      position: positionData?.position ?? Duration.zero,
                      bufferedPosition:
                          positionData?.bufferedPosition ?? Duration.zero,
                      onChangeEnd: widget
                          .audioPlayerListTileProps.value.audioPlayer!.seek,
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          GestureDetector(
            onTap: () async {
              widget.audioPlayerListTileProps.value = await widget
                  .audioPlayerListTileProps.value
                  .disposePlayer(widget.song.id);

              context.push(
                Routes.ADD_TRACK.value,
                extra: AddTrackPageParams(widget.song),
              );
            },
            onDoubleTap: () {
              widget.audioPlayerListTileProps.value.togglePlayPause();
            },
            onLongPress: () async {
              // dispose the player if it is already there.
              AudioPlayerListTileProps audioPlayerCollection =
                  widget.audioPlayerListTileProps.value;

              if (audioPlayerCollection.audioPlayer != null) {
                audioPlayerCollection =
                    await audioPlayerCollection.disposePlayer(widget.song.id);
              }

              if (audioPlayerCollection.audioPlayer == null) {
                audioPlayerCollection = await audioPlayerCollection.initPlayer(
                  url: widget.song.previewUrl,
                  songId: widget.song.id,
                );
              }

              widget.audioPlayerListTileProps.value = audioPlayerCollection;
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(widget.song.image),
                  ),
                  const SizedBox(width: 0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.song.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                         Text(
                            widget.song.artistName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  widget.trailing ?? const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
