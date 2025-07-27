import 'package:app/models/audio_player_tile/audio_player_list_tile_props.dart';
import 'package:app/models/song/Song.dart';
import 'package:app/ui/add/master.dart';
import 'package:app/ui/search/search_cubit.dart';
import 'package:app/ui/search/widgets/audio_player_list_tile.dart';
import 'package:app/ui/widgets/custom_scaffold.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchTrackPage extends StatelessWidget {
  final ValueNotifier<AudioPlayerListTileProps> audioPlayerNotifier =
      ValueNotifier(AudioPlayerListTileProps());

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
              return AudioPlayerListTile(
                audioPlayerListTileProps: audioPlayerNotifier,
                song: song,

              );
            },
          );
        }),
      ),
    );
  }
}
