import 'package:app/models/task/Task.dart';
import 'package:app/ui/home/state/home_cubit.dart';
import 'package:app/ui/home/state/home_state.dart';
import 'package:app/ui/home/widgets/task_card.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/empty_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      floatingActionButton:
          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state.tasks.isNotEmpty) {
          return FloatingActionButton(
            onPressed: context.read<ImageCubit>().onSelectFileButtonPressed,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          );
        }
        return const SizedBox.shrink();
      }),
      appBar: AppBar(
        title: Text(
          "TuneInsta",
          style: TextStyle(
            color: Colors.brown.shade900,
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
        actions: [
          // ElevatedButton(
          //   onPressed: () {
          //     context.push(Routes.DOCK_TEST.value);
          //   },
          //   child: const Text("Test"),
          // ),
          // const SizedBox(width: 12),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state.tasks.isEmpty) {
                return const EmptyState();
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 25,
                  bottom: 150,
                ),
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final Task task = state.tasks[index];
                  return TaskCard(task: task);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
