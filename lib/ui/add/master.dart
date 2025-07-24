import 'package:app/models/song/Song.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/ui/widgets/custom_scaffold.dart';
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
      body: Form(
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

            DropdownButton<Genre>(
              value: genre,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (Genre? newValue) {
                setState(() {
                  genre = newValue!;
                });
              },

              items: Genre.values.map<DropdownMenuItem<Genre>>((Genre value) {
                return DropdownMenuItem<Genre>(
                  value: value,
                  child: Text(value.toString().split('.').last.toUpperCase()),
                );
              }).toList(),
            ),

            DropdownButton<Mood>(
              value: mood,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (Mood? newValue) {
                setState(() {
                  mood = newValue!;
                });
              },

              items: Mood.values.map<DropdownMenuItem<Mood>>((Mood value) {
                return DropdownMenuItem<Mood>(
                  value: value,
                  child: Text(value.toString().split('.').last.toUpperCase()),
                );
              }).toList(),
            ),

            TextButton(
              onPressed: () async {
                if(_formKey.currentState == null) return;
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
    );
  }
}
