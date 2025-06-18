import 'dart:io';

import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  void initState() {
    super.initState();
    context.read<ImageCubit>().onImageViewInit();
  }

  @override
  Widget build(BuildContext context) {
    final imageState = context.read<ImageCubit>().state;

    if (imageState.selectedTask.localFilePath != null) {
      return Image.file(
        File(imageState.selectedTask.localFilePath!),
        fit: BoxFit.cover,
      );
    }
    if (imageState.selectedTask.imageUrl != null) {
      return CachedImage(
        imageState.selectedTask.imageUrl!,
        fit: BoxFit.cover,
      );
    }

    return const Center(
      child: Text('No image url'),
    );
  }
}
