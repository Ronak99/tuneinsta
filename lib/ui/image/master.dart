import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/image/state/image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/background_view.dart';
import 'widgets/dock/animated_dock_view.dart';
import 'widgets/image_view.dart';
import 'widgets/share_chip_view.dart';

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
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ImageView(),
            const BackgroundView(),

            // share chips
            const ShareChipView(),

            // dock
            BlocBuilder<ImageCubit, ImageState>(
              builder: (context, state) => AnimatedDockView(
                songs: state.selectedTask.songs,
                taskStatus: state.selectedTask.status,
              ),
            ),

            // top bar
            _buildTopBar(context),
          ],
        ),
      ),
    );
  }
}