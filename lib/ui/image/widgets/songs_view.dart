import 'package:app/models/song/Song.dart';
import 'package:app/ui/image/widgets/audio_player_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SongsView extends StatelessWidget {
  final List<Song> songs;

  const SongsView({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    ValueNotifier<int> pageNotifier = ValueNotifier(0);

    return Stack(
      children: [
        ValueListenableBuilder<int>(
            valueListenable: pageNotifier,
            builder: (context, page, _) {
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if(notification is ScrollEndNotification) {
                      final PageMetrics metrics =
                          notification.metrics as PageMetrics;
                      final double? currentPage = metrics.page;
                      pageNotifier.value = currentPage!.round();
                  }
                  return false;
                },
                child: PageView.builder(
                  itemCount: songs.length,
                  pageSnapping: true,
                  padEnds: false,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    Song song = songs[index];
                    return AudioPlayerView(
                      song: song,
                      shouldPlay: page == index,
                    );
                  },
                ),
              );
            }),
        if (songs.isNotEmpty)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8, left: 50),
              child: SmoothPageIndicator(
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
            ),
          ),
      ],
    );
  }
}
