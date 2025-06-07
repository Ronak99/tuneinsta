import 'package:app/models/song/Song.dart';
import 'package:app/ui/image/widgets/audio_player_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SongsView extends StatelessWidget {
  final List<Song> songs;

  const SongsView({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: songs.length,
            controller: pageController,
            itemBuilder: (context, index) {
              Song song = songs[index];

              return AudioPlayerView(song: song);
            },
          ),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: songs.length,
          effect: const ExpandingDotsEffect(
            dotColor: Colors.white70,
            activeDotColor: Colors.white,
            dotWidth: 4,
            dotHeight: 4,
            radius: 12,
            expansionFactor: 3,
            spacing: 4,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
