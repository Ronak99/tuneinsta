import 'package:app/models/task/Task.dart';
import 'package:app/ui/home/widgets/card_action_button.dart';
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
              CardActionButton(status: task.status),
            ],
          ),
        ),
      ),
    );
  }
}