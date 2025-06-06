import 'dart:io';

import 'package:app/models/song/Song.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/image/state/image_state.dart';
import 'package:app/ui/image/widgets/audio_player_view.dart';
import 'package:app/ui/widgets/cached_image.dart';
import 'package:app/utils/task_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewImagePage extends StatelessWidget {
  const ViewImagePage({
    super.key,
  });

  Widget _buildTopBar(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: 12,
          right: 12,
          top: MediaQuery.of(context).padding.top + 16,
        ),
        child: Row(
          children: [
            _buildActionButton(
              onPressed: () => context.pop(),
              icon: Icons.arrow_back_ios_rounded,
            ),
            const Spacer(),
            _buildActionButton(
              onPressed: () => {},
              icon: Icons.ios_share,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        height: 45,
        width: 45,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ImageView(),
            _buildTopBar(context),
            const DockView(),
          ],
        ),
      ),
    );
  }
}

class DockView extends StatelessWidget {
  const DockView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageState>(builder: (context, state) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 100,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 4,
          ),
          child: Builder(builder: (context) {
            switch (state.selectedTask.status) {
              case TaskStatus.initial:
                return const Text('initial');
              case TaskStatus.error:
                return const Text('error occurred');
              case TaskStatus.curating:
                return const Text('curating');
              case TaskStatus.uploading:
                return const Text('uploading');
              case TaskStatus.processing:
                return const Text('AI doing its thing');
              case TaskStatus.complete:
                return SongsView(
                  songs: state.selectedTask.songs,
                );
            }
          }),
        ),
      );
    });
  }
}

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

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  void initState() {
    super.initState();
    context.read<ImageCubit>().onImageViewInit();
  }

  @override
  Widget build(BuildContext context) {
    final imageState = context.read<ImageCubit>().state;

    if (imageState.selectedTask.file != null) {
      return Image.file(
        imageState.selectedTask.file!,
        fit: BoxFit.cover,
      );
    }
    if (!imageState.selectedTask.isLocalImage) {
      return CachedImage(
        imageState.selectedTask.imageUrl,
        fit: BoxFit.cover,
      );
    }

    return const SizedBox.shrink();
  }
}
