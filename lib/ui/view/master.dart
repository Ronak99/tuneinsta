import 'package:app/models/audio_player_tile/audio_player_list_tile_props.dart';
import 'package:app/models/song/Song.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/ui/feedback/feedback_dialog.dart';
import 'package:app/ui/search/widgets/audio_player_list_tile.dart';
import 'package:app/ui/widgets/custom_scaffold.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ViewAllTracksParams {
  final bool isAdmin;

  ViewAllTracksParams({required this.isAdmin});
}

class ViewAllTracks extends StatelessWidget {
  final ViewAllTracksParams params;

  final ValueNotifier<AudioPlayerListTileProps> audioPlayerNotifier =
      ValueNotifier(AudioPlayerListTileProps());

  ViewAllTracks({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "View All Tracks",
      actions: [
        if(!params.isAdmin)
          TextButton(
            child: const Text("Feedback"),
            onPressed: () => FeedbackDialog.show(context: context),
          )
      ],
      fab: FloatingActionButton(
        onPressed: () => context.push(Routes.SEARCH_TRACKS.value),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.search,
          size: 30,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: StreamBuilder<List<Song>>(
          stream: Get.find<DbService>().streamSongsDirectory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No Songs"),
                );
              }

              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (context, index) {
                  Song song = snapshot.data![index];
                  return AudioPlayerListTile(
                    audioPlayerListTileProps: audioPlayerNotifier,
                    song: song,
                    isDisabled: !params.isAdmin,
                    trailing: params.isAdmin
                        ? IconButton(
                            onPressed: () {
                              Get.find<DbService>().deleteSong(song.id);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        : null,
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
