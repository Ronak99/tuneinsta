import 'package:app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardActionButton extends StatelessWidget {
  final TaskStatus status;

  const CardActionButton({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.only(right: 12, bottom: 12),
        height: 40,
        width: 40,
        child: Builder(builder: (context) {
          switch (status) {
            case TaskStatus.initial:
              return const SizedBox.shrink();
            case TaskStatus.error:
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Lottie.asset(
                  'assets/error_lottie.json',
                  repeat: false,
                ),
              );
            case TaskStatus.uploading:
              return Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  shape: BoxShape.circle,
                ),
                child: Lottie.asset('assets/upload_lottie.json'),
              );
            case TaskStatus.curating:
            case TaskStatus.processing:
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: Transform.scale(
                  scale: 2,
                  child: Lottie.asset('assets/ai_lottie.json'),
                ),
              );
            case TaskStatus.complete:
              return Container(
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
