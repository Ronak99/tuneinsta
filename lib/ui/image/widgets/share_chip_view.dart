import 'package:app/models/share/AppShare.dart';
import 'package:app/services/share_service.dart';
import 'package:app/ui/image/state/image_cubit.dart';
import 'package:app/ui/image/state/image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ShareChipView extends StatelessWidget {
  const ShareChipView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = 40;
    int chipCountThreshold = 4;

    List<AppShare> appList = Get.find<ShareService>().apps;

    Widget buildChip({
      required bool shouldShow,
      required int index,
      required AppShare app,
      required bool isInThreshold,
      required bool isLast,
    }) {
      return AnimatedOpacity(
        opacity: shouldShow ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: AnimatedSlide(
          offset: Offset(0, shouldShow ? 0 : 1 + index * .5),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: GestureDetector(
            onTap: () =>
                context.read<ImageCubit>().onShareButtonTap(context, appShare: app),
            child: Container(
              height: height,
              margin: EdgeInsets.only(right: isLast ? 16 : 8),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Image.asset(
                    app.icon,
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  ),
                  if (isInThreshold)
                    Expanded(
                      child: Text(
                        app.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    )
                  else
                    Row(
                      children: [
                        const SizedBox(width: 12),
                        Text(
                          app.label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                    ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 80 + 12 + 8,
          ),
          height: height,
          width: double.infinity,
          child: BlocBuilder<ImageCubit, ImageState>(
            buildWhen: (prev, curr) =>
                prev.selectedTask.downloadedFilePath !=
                curr.selectedTask.downloadedFilePath,
            builder: (context, state) {
              bool shouldShow = state.selectedTask.downloadedFilePath != null;
              if (appList.length < chipCountThreshold) {
                return Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: appList.map((app) {
                      int index = appList.indexOf(app);
                      return Expanded(
                        child: buildChip(
                          shouldShow: shouldShow,
                          index: index,
                          app: app,
                          isLast: index == appList.length -1,
                          isInThreshold: true,
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: appList.length,
                  padding: const EdgeInsets.only(left: 16),
                  itemBuilder: (context, index) {
                    return buildChip(
                      shouldShow: shouldShow,
                      index: index,
                      app: appList[index],
                      isLast: index == appList.length -1,
                      isInThreshold: false,
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
