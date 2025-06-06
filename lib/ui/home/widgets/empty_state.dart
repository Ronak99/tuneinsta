import 'package:app/ui/home/state/home_cubit.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    double size = 145;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/search.png',
          height: size,
          width: size,
        ),
        const SizedBox(height: 12),
        Text(
          "Find the right tune",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.brown.shade900,
          ),
        ),
        Text(
          "for your images from an eclectic collection.",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.brown.shade800,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GestureDetector(
            onTap: context.read<ImageCubit>().onSelectFileButtonPressed,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.brown.shade800,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo,
                    color: Colors.brown.shade50,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Upload an image",
                    style: TextStyle(
                      color: Colors.brown.shade50,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
