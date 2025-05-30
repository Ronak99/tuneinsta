import 'dart:io';

import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/ui/home/state/home_cubit.dart';
import 'package:app/ui/home/state/home_state.dart';
import 'package:app/ui/image/master.dart';
import 'package:app/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
            onPressed: context.read<HomeCubit>().onSelectFileButtonPressed,
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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
            itemCount: 12,
            itemBuilder: (context, index) {
              final url = "https://www.picsum.photos/20$index";
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
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GestureDetector(
                          onTap: () => context.read<HomeCubit>().onImageTap(url),
                          child: Hero(
                            tag: url,
                            child: Image.network(url),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     // ObxValue(
          //     //   (progress) {
          //     //     return progress > 0 && progress < 1
          //     //         ? const CircularProgressIndicator(
          //     //             value: 0,
          //     //             backgroundColor: Colors.white,
          //     //           )
          //     //         : const SizedBox.shrink();
          //     //   },
          //     //   Get.find<StorageService>().uploadProgress,
          //     // ),
          //     const SizedBox(height: 12),
          //     TextButton(
          //       onPressed: context.read<HomeCubit>().makeTestFirestoreRecord,
          //       child: Text("Make Test Request"),
          //     ),
          //     const SizedBox(height: 12),
          //
          //     Container(
          //       height: 200,
          //       width: double.infinity,
          //       padding: const EdgeInsets.all(20),
          //       margin: const EdgeInsets.symmetric(horizontal: 16),
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(16),
          //           boxShadow: [
          //             BoxShadow(
          //                 color: Colors.brown.withOpacity(.1),
          //                 spreadRadius: 1,
          //                 blurRadius: 4,
          //                 offset: Offset(0, 0)),
          //           ]),
          //       child: const Text(
          //         "RONAK PUNASE",
          //         style: TextStyle(fontSize: 30, fontFamily: "SFUIText"),
          //       ),
          //     ),
          //     BlocBuilder<HomeCubit, HomeState>(
          //       builder: (context, state) {
          //         if (state.selectedFile != null) {
          //           return Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Stack(
          //                 children: [
          //                   Image.file(state.selectedFile!),
          //                 ],
          //               ),
          //               const SizedBox(height: 12),
          //               TextButton(
          //                 onPressed:
          //                     context.read<HomeCubit>().onUploadFileButtonPressed,
          //                 child: const Text(
          //                   "Upload File",
          //                 ),
          //               ),
          //             ],
          //           );
          //         }
          //
          //         return TextButton(
          //           onPressed:
          //               context.read<HomeCubit>().onSelectFileButtonPressed,
          //           child: const Text(
          //             "Select a file",
          //           ),
          //         );
          //       },
          //     ),
          //     const SizedBox(height: 12),
          //     BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          //       switch (state.processState) {
          //         case ProcessState.initial:
          //         case ProcessState.complete:
          //           return const Text("YOYO");
          //         case ProcessState.uploading:
          //           return const Text('Uploading...');
          //         case ProcessState.processing:
          //           if (state.taskId == null)
          //             return Text('Task ID is still null');
          //           return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          //             stream: Get.find<DbService>().taskStream(state.taskId!),
          //             builder: (context, snapshot) {
          //               Map<String, dynamic> taskSnapshot =
          //                   snapshot.data?.data() ?? {};
          //
          //               if (taskSnapshot.containsKey('song')) {
          //                 return Column(
          //                   children: (taskSnapshot['song'] as List<dynamic>)
          //                       .map((song) => Text(song))
          //                       .toList(),
          //                 );
          //               }
          //
          //               return Text('AI is doing its thing...');
          //             },
          //           );
          //       }
          //     }),
          //   ],
          // ),
          //
        ),
      ),
    );
  }
}
