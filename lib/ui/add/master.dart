import 'package:app/models/song/Song.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/ui/add/widgets/custom_selector.dart';
import 'package:app/ui/widgets/custom_scaffold.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AddTrackPageParams {
  final Song song;

  AddTrackPageParams(this.song);
}

class AddTrackPage extends StatefulWidget {
  final AddTrackPageParams addTrackPageParams;

  const AddTrackPage({super.key, required this.addTrackPageParams});

  @override
  State<AddTrackPage> createState() => _AddTrackPageState();
}

class _AddTrackPageState extends State<AddTrackPage> {
  late List<Mood> moodList;
  late List<Genre> genreList;

  late Mood selectedMood;
  late Genre selectedGenre;

  late String title;
  late String artistName;

  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    moodList = List.from(widget.addTrackPageParams.song.mood);
    selectedMood = widget.addTrackPageParams.song.mood.first;

    genreList = List.from(widget.addTrackPageParams.song.genre);
    selectedGenre = widget.addTrackPageParams.song.genre.first;

    title = widget.addTrackPageParams.song.title;
    artistName = widget.addTrackPageParams.song.artistName;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Add Track",
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                onSaved: (value) {
                  title = value!;
                },
                decoration: const InputDecoration(
                  hintText: "Track Name",
                ),
              ),
              TextFormField(
                initialValue: artistName,
                onSaved: (value) {
                  artistName = value!;
                },
                decoration: const InputDecoration(
                  hintText: "Artist Name",
                ),
              ),
              CustomSelector<Genre>(
                allItems: Genre.values,
                label: 'GENRE',
                onAdd: (genre)  {
                  setState(() {
                    genreList.add(genre);
                  });
                },
                onRemove: (genre) {
                  setState(() {
                    genreList.remove(genre);
                  });
                },
                selectedItems: genreList,
                getLabel: (genre) => genre.name,
              ),
              CustomSelector<Mood>(
                allItems: Mood.values,
                selectedItems: moodList,
                label: 'MOOD',
                onAdd: (mood)  {
                  setState(() {
                    moodList.add(mood);
                  });
                },
                onRemove: (mood) {
                  setState(() {
                    moodList.remove(mood);
                  });
                },
                getLabel: (mood) => mood.name,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState == null) return;
                    _formKey.currentState!.save();

                    setState(() {
                      isLoading = true;
                    });

                    final song = widget.addTrackPageParams.song.copyWith(
                      addedOn: DateTime.now().millisecondsSinceEpoch,
                      artistName: artistName,
                      genre: genreList,
                      mood: moodList,
                      title: title,
                    );

                    await Get.find<DbService>().addSong(song);

                    context.pop();
                    context.pop();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown.shade800,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Add Track",
                      style: TextStyle(
                        color: Colors.brown.shade50,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
