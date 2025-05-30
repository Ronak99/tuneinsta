import 'package:app/ui/home/state/home_cubit.dart';
import 'package:app/ui/home/state/home_state.dart';
import 'package:app/ui/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

//
// class ViewImagePageParams {
//   final String tag;
//   final String url;
//
//   ViewImagePageParams({
//     required this.tag,
//     required this.url,
//   });
// }

class ViewImagePage extends StatelessWidget {
  // final ViewImagePageParams params;

  const ViewImagePage({
    super.key,
    // required this.params,
  });

  Widget _buildTopBar(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 16,
        ),
        child: Row(
          children: [
            _buildActionButton(
              onPressed: () => context.pop(),
              icon: Icons.arrow_back_ios_rounded,
            ),
            const Spacer(),
            _buildActionButton(
              onPressed: () => {},
              icon: Icons.ios_share,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        height: 45,
        width: 45,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBottomPlayerView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 12,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        CachedImage(
                          'https://www.picsum.photos/50',
                          radius: 100,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Song Name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Artist Name",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 45,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: "params.tag",
                transitionOnUserGestures: true,
                child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if(state.selectedFile != null){
                        return Image.file(state.selectedFile!);
                      }if(state.selectedImage != null){
                        return Image.network(state.selectedImage!);
                      }
                      return Text("oops");
                    }),
              ),
              _buildTopBar(context),
              _buildBottomPlayerView(),
            ],
          ),
        ),
      ),
    );
  }
}
