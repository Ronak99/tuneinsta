import 'package:app/models/task/Task.dart';
import 'package:app/services/db_service.dart';
import 'package:app/ui/home/state/home_cubit.dart';
import 'package:app/ui/home/state/home_state.dart';
import 'package:app/ui/home/widgets/task_card.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/view/master.dart';
import 'package:app/ui/widgets/custom_scaffold.dart';
import 'package:app/utils/routes.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'widgets/empty_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int _count = 0;
    ValueNotifier<bool> showPasswordField = ValueNotifier<bool>(false);

    return CustomScaffold(
      fab: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
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
      actions: [
        if (kDebugMode)
          TextButton(
            onPressed: () => context.push(Routes.VIEW_ALL_TRACKS.value, extra: ViewAllTracksParams(isAdmin: true)),
            child: const Text("View"),
          ),
        ValueListenableBuilder<bool>(
          valueListenable: showPasswordField,
          builder: (context, state, child) {
            if (state) {
              return child!;
            }
            return const SizedBox.shrink();
          },
          child: Expanded(
            child: TextField(
              decoration: const InputDecoration(hintText: 'Password'),
              onSubmitted: (value) {
                final dbService = Get.find<DbService>();
                if (value == dbService.adminPassword ||
                    value == dbService.testerPassword) {
                  context.push(
                    Routes.VIEW_ALL_TRACKS.value,
                    extra: ViewAllTracksParams(
                      isAdmin: value == dbService.adminPassword,
                    ),
                  );
                  showPasswordField.value = false;
                }
              },
            ),
          ),
        ),
      ],
      title: "Tuneinsta",
      onTitleTap: () {
        _count++;

        EasyDebounce.debounce('tag', const Duration(seconds: 1), () {
          _count = 0;
        });

        if (_count >= 5) {
          _count = 0;
          showPasswordField.value = true;

          EasyDebounce.debounce('tag', const Duration(seconds: 10), () {
            showPasswordField.value = false;
          });
        }
      },
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
