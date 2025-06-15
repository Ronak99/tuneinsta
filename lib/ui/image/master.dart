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
            const Spacer(),
            BlocBuilder<ImageCubit, ImageState>(builder: (context, state) {
              return AnimatedOpacity(
                opacity: state.selectedTask.isComplete ? 1 : 0,
                duration: const Duration(milliseconds: 350),
                child: _buildActionButton(
                  onPressed: () {
                    if (state.selectedTask.isComplete) {
                      return;
                    }
                  },
                  icon: Icons.ios_share,
                ),
              );
            }),
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
                    opacity: state.selectedTask.status == TaskStatus.curating || state.selectedTask.status == TaskStatus.processing
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
