import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/image/state/image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShareChipView extends StatelessWidget {
  const ShareChipView({super.key});

  String getLabel(ShareType shareType) {
    switch (shareType) {
      case ShareType.instaStory:
        return "Share it on Story";
      case ShareType.instaFeed:
        return "Share it on Feed";
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = 40;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 80 + 12 + 8,
            left: 16,
          ),
          height: height,
          width: double.infinity,
          child: BlocBuilder<ImageCubit, ImageState>(
            buildWhen: (prev, curr) =>
                prev.selectedTask.downloadedFilePath !=
                curr.selectedTask.downloadedFilePath,
            builder: (context, state) {
              bool shouldShow = state.selectedTask.downloadedFilePath != null;
              return Row(
                children: ShareType.values.map((type) {
                  int index = ShareType.values.indexOf(type);
                  bool isLast = index == ShareType.values.length - 1;
                  return Expanded(
                    child: AnimatedOpacity(
                      opacity: shouldShow ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: AnimatedSlide(
                        offset: Offset(0, shouldShow ? 0 : 1 + index * .5),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: GestureDetector(
                          onTap: () =>
                              context.read<ImageCubit>().onShareButtonTap(
                                    shareType: type,
                                  ),
                          child: Container(
                            height: height,
                            margin: EdgeInsets.only(right: isLast ? 16 : 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/instagram.png',
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Text(
                                    getLabel(type),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )),
    );
  }
}
