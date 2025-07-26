import 'package:app/models/song/Song.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
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
  late Mood mood;
  late Genre genre;
  late String title;
  late String artistName;

  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    mood = widget.addTrackPageParams.song.mood;
    genre = widget.addTrackPageParams.song.genre;
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
              DropdownMenu<Genre>(
                width: MediaQuery.of(context).size.width,
                initialSelection: genre,
                dropdownMenuEntries:
                    Genre.values.map<DropdownMenuEntry<Genre>>((Genre value) {
                  return DropdownMenuEntry<Genre>(
                    value: value,
                    label: value.name,
                    // child: Text(value.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onSelected: (Genre? selectedGenre) {
                  setState(() {
                    genre = selectedGenre!;
                  });
                },
              ),
              DropdownMenu<Mood>(
                width: double.infinity,
                initialSelection: mood,
                dropdownMenuEntries:
                Mood.values.map<DropdownMenuEntry<Mood>>((Mood value) {
                  return DropdownMenuEntry<Mood>(
                    value: value,
                    label: value.name,
                  );
                }).toList(),
                onSelected: (Mood? selectedMood) {
                  setState(() {
                    mood = selectedMood!;
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState == null) return;
                  _formKey.currentState!.save();

                  setState(() {
                    isLoading = true;
                  });

                  final song = widget.addTrackPageParams.song.copyWith(
                    addedOn: DateTime.now().millisecondsSinceEpoch,
                    artistName: artistName,
                    genre: genre,
                    mood: mood,
                    title: title,
                  );

                  await Get.find<DbService>().addSong(song);

                  context.pop();
                  context.pop();
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
