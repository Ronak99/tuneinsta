import 'package:app/majestic/ui/grid_background/grid_background.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/image/state/image_state.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundView extends StatelessWidget {
  const BackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageState>(builder: (context, state) {
      return AnimatedOpacity(
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
      );
    });
  }
}
