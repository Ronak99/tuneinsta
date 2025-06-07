import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/image/state/image_state.dart';
import 'package:app/ui/image/widgets/songs_view.dart';
import 'package:app/utils/task_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                return const SizedBox.shrink();
              case TaskStatus.complete:
                return const Text('error occurred');
              case TaskStatus.curating:
                return const Text('curating');
              case TaskStatus.uploading:
                return const Text('uploading');
              case TaskStatus.processing:
                return const Text('AI doing its thing');
              case TaskStatus.error:
                return const SizedBox.shrink();
                // return SongsView(
                //   songs: state.selectedTask.songs,
                // );
            }
          }),
        ),
      );
    });
  }
}
