import 'dart:io';

import 'package:app/services/db_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/ui/home/state/home_cubit.dart';
import 'package:app/ui/home/state/home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ObxValue(
              (progress) {
                return progress > 0 && progress < 1
                    ? const CircularProgressIndicator(
                        value: 0,
                        backgroundColor: Colors.white,
                      )
                    : const SizedBox.shrink();
              },
              Get.find<StorageService>().uploadProgress,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: context.read<HomeCubit>().makeTestFirestoreRecord,
              child: Text("Make Test Request"),
            ),
            const SizedBox(height: 12),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.selectedFile != null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Image.file(state.selectedFile!),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed:
                            context.read<HomeCubit>().onUploadFileButtonPressed,
                        child: const Text(
                          "Upload File",
                        ),
                      ),
                    ],
                  );
                }

                return TextButton(
                  onPressed:
                      context.read<HomeCubit>().onSelectFileButtonPressed,
                  child: const Text(
                    "Select a file",
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              switch (state.processState) {
                case ProcessState.initial:
                case ProcessState.complete:
                  return const Text("YOYO");
                case ProcessState.uploading:
                  return const Text('Uploading...');
                case ProcessState.processing:
                  if (state.taskId == null)
                    return Text('Task ID is still null');
                  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: Get.find<DbService>().taskStream(state.taskId!),
                    builder: (context, snapshot) {
                      Map<String, dynamic> taskSnapshot =
                          snapshot.data?.data() ?? {};

                      if (taskSnapshot.containsKey('song')) {
                        return Column(
                          children: (taskSnapshot['song'] as List<dynamic>)
                              .map((song) => Text(song))
                              .toList(),
                        );
                      }

                      return Text('AI is doing its thing...');
                    },
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}
