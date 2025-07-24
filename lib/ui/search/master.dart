import 'package:app/models/song/Song.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/ui/add/master.dart';
import 'package:app/ui/search/search_cubit.dart';
import 'package:app/ui/widgets/custom_scaffold.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SearchTrackPage extends StatelessWidget {
  const SearchTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return CustomScaffold(
      title: "Search Track",
      fab: FloatingActionButton(
        onPressed: () => context.push(Routes.ADD_TRACK.value),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TextField(onChanged: searchCubit.onSearchValueChange),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator();
          }
          if (state.results.isEmpty) {
            return const Center(
              child: Text("No Songs"),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              Song song = state.results[index];
              return ListTile(
                title: Text(song.title),
                subtitle: Text(song.artistName),
                leading: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(song.image),
                ),
                trailing: IconButton(
                  onPressed: () => context.push(
                    Routes.ADD_TRACK.value,
                    extra: AddTrackPageParams(song),
                  ),
                  icon: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
