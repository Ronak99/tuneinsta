import 'package:app/models/song/Song.dart';
import 'package:app/ui/image/widgets/dock/animated_dock_view.dart';
import 'package:app/utils/task_status.dart';
import 'package:flutter/material.dart';

class NewDockTestPage extends StatefulWidget {
  const NewDockTestPage({super.key});

  @override
  State<NewDockTestPage> createState() => _NewDockTestPageState();
}

class _NewDockTestPageState extends State<NewDockTestPage> {
  TaskStatus status = TaskStatus.initial;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: TaskStatus.values
                  .map(
                    (e) => TextButton(
                      onPressed: () {
                        setState(() {
                          status = e;
                        });
                      },
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
            ),
            AnimatedDockView(
              taskStatus: status,
              songs: [
                Song(
                  title: "Home (feat. The Gulu Widows Choir)",
                  artistName: "Edward Sharpe & The Magnetic Zeros",
                  image: "https://is1-ssl.mzstatic.com/image/thumb/Music/4a/b3/28/mzi.zdwkbnng.jpg/100x100bb.jpg",
                  previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/75/67/84/756784dd-c082-0e92-4de7-81341ce7b58c/mzaf_6507255910992083821.plus.aac.p.m4a",
                ),
                Song(
                  title: "Home (feat. The Gulu Widows Choir)",
                  artistName: "Edward Sharpe & The Magnetic Zeros",
                  image:
                      "https://is1-ssl.mzstatic.com/image/thumb/Music/4a/b3/28/mzi.zdwkbnng.jpg/100x100bb.jpg",
                  previewUrl:
                      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/75/67/84/756784dd-c082-0e92-4de7-81341ce7b58c/mzaf_6507255910992083821.plus.aac.p.m4a",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
