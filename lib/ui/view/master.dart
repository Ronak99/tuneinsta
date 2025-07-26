import 'package:app/models/song/Song.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/ui/widgets/custom_scaffold.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ViewAllTracks extends StatelessWidget {
  const ViewAllTracks({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "View All Tracks",
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
                  return ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.artistName),
                    leading: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(song.image),
                    ),
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
