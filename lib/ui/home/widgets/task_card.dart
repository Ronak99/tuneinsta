import 'package:app/models/task/Task.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/widgets/cached_image.dart';
import 'package:app/utils/task_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          onTap: () => context.read<ImageCubit>().onTaskTap(task),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedImage(
                task.imageUrl!,
                fit: BoxFit.cover,
              ),
              TaskStatusView(task: task),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskStatusView extends StatelessWidget {
  final Task task;

  const TaskStatusView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.only(right: 12, bottom: 12),
        child: Builder(builder: (context) {
          switch (task.status) {
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
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
              );
          }
        }),
      ),
    );
  }
}
