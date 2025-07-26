import 'package:app/models/song/Song.dart';
import 'package:app/ui/image/widgets/songs_view.dart';
import 'package:app/ui/widgets/cached_image.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'curves/curves.dart';

typedef DockDimensions = (double height, double width, double radius);

class AnimatedDockView extends StatelessWidget {
  final TaskStatus taskStatus;
  final List<Song> songs;

  const AnimatedDockView({
    super.key,
    required this.taskStatus,
    required this.songs,
  });

  Widget buildChip({
    required Widget icon,
    required String text,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: icon),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget get getChild => switch (taskStatus) {
        TaskStatus.initial => const SizedBox.shrink(),
        TaskStatus.uploading => buildChip(
            text: 'Uploading',
            icon: Container(
              margin: const EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                shape: BoxShape.circle,
              ),
              height: 35,
              width: 35,
              child: Lottie.asset('assets/upload_lottie.json'),
            ),
          ),
        TaskStatus.processing || TaskStatus.curating => buildChip(
            text: 'Technologia',
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                shape: BoxShape.circle,
              ),
              height: 35,
              width: 35,
              child: Transform.scale(
                scale: 2,
                child: Lottie.asset('assets/ai_lottie.json'),
              ),
            ),
          ),
        TaskStatus.complete => SongsView(songs: songs),
        TaskStatus.error => buildChip(
            text: 'An error occurred.',
            icon: SizedBox(
              height: 35,
              width: 35,
              child: Lottie.asset(
                'assets/error_lottie.json',
                repeat: false,
              ),
            ),
          ),
      };

  DockDimensions getDimensions(BuildContext context) => switch (taskStatus) {
        TaskStatus.initial => (0, 0, 0),
        TaskStatus.uploading => (55, 140, 40),
        TaskStatus.processing || TaskStatus.curating => (55, 150, 40),
        TaskStatus.error => (55, 350, 40),
        TaskStatus.complete => (80, MediaQuery.of(context).size.width - 35, 12),
      };

  @override
  Widget build(BuildContext context) {
    DockDimensions dockDimensions = getDimensions(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        height: dockDimensions.$1,
        width: dockDimensions.$2,
        duration: const Duration(milliseconds: 350),
        curve: const SmoothCurvePrecise(),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dockDimensions.$3),
          color: Colors.black54,
        ),
        child: getChild,
      ),
    );
  }
}
