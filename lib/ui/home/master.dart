import 'package:app/models/task/Task.dart';
import 'package:app/services/db_service.dart';
import 'package:app/ui/home/widgets/home_cubit.dart';
import 'package:app/ui/home/widgets/home_state.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/widgets/cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
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
          ElevatedButton(
            onPressed: context.read<ImageCubit>().onSelectFileButtonPressed,
            child: const Text("Upload"),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                return const Center(
                  child: Text('Find the right tune to your images'),
                );
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
                  top: 24,
                  bottom: 16,
                ),
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final Task task = state.tasks[index];

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
                        ]),
                    child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () => context
                                  .read<ImageCubit>()
                                  .onImageTap(task.imageUrl),
                              child: CachedImage(task.imageUrl,fit: BoxFit.cover,),
                            ),
                          ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
