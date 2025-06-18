import 'dart:io';

import 'package:app/majestic/ui/grid_background/grid_background.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/image/state/image_state.dart';
import 'package:app/ui/widgets/cached_image.dart';
import 'package:app/utils/task_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/dock/animated_dock_view.dart';

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
        child: BlocBuilder<ImageCubit, ImageState>(
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: [
                const ImageView(),
                AnimatedOpacity(
                  opacity: state.selectedTask.status == TaskStatus.curating ||
                          state.selectedTask.status == TaskStatus.processing
                      ? 1
                      : 0,
                  duration: const Duration(milliseconds: 350),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                    ),
                    child: GridBackground(
                      animationColor: CupertinoColors.white.withOpacity(.6),
                      gridColor: CupertinoColors.activeBlue.withOpacity(.2),
                      gridSpacing: 4,
                      child: Container(),
                    ),
                  ),
                ),
                const ShareChipView(),
                AnimatedDockView(
                  taskStatus: state.selectedTask.status,
                  songs: state.selectedTask.songs,
                ),
                _buildTopBar(context),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ShareChipView extends StatelessWidget {
  const ShareChipView({super.key});

  String getLabel(ShareType shareType) {
    switch (shareType) {
      case ShareType.instaStory:
        return "Share it on Story";
      case ShareType.instaFeed:
        return "Share it on Feed";
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = 40;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 80 + 12 + 8,
            left: 16,
          ),
          height: height,
          width: double.infinity,
          child: BlocBuilder<ImageCubit, ImageState>(
            buildWhen: (prev, curr) =>
                prev.selectedTask.downloadedFilePath !=
                curr.selectedTask.downloadedFilePath,
            builder: (context, state) {
              bool shouldShow = state.selectedTask.downloadedFilePath != null;
              return Row(
                children: ShareType.values
                    .map(
                      (type) {
                        int index = ShareType.values.indexOf(type);
                        bool isLast = index == ShareType.values.length - 1;
                        return Expanded(
                          child: AnimatedOpacity(
                            opacity: shouldShow ? 1 : 0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: AnimatedSlide(
                              offset: Offset(
                                  0,
                                  shouldShow
                                      ? 0
                                      : 1 +  index * .5),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: GestureDetector(
                                onTap: () =>
                                    context.read<ImageCubit>().onShareButtonTap(
                                      shareType: type,
                                    ),
                                child: Container(
                                  height: height,
                                  margin: EdgeInsets.only(right: isLast ? 16: 8),
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/instagram.png',
                                        height: 20,
                                        width: 20,
                                        color: Colors.white,
                                      ),
                                      Expanded(
                                        child: Text(
                                          getLabel(type),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    )
                    .toList(),
              );
            },
          )),
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

    if (imageState.selectedTask.localFilePath != null) {
      return Image.file(
        File(imageState.selectedTask.localFilePath!),
        fit: BoxFit.cover,
      );
    }
    if (imageState.selectedTask.imageUrl != null) {
      return CachedImage(
        imageState.selectedTask.imageUrl!,
        fit: BoxFit.cover,
      );
    }

    return const Center(
      child: Text('No image url'),
    );
  }
}
