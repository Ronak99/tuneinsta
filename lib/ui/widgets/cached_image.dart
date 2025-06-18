import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatefulWidget {
  final String imageUrl;
  final bool isRound;
  final double radius;
  final double? height;
  final double? width;
  final BoxFit fit;
  final bool useOldImageOnUrlChange;
  final bool noPlaceHolder;

  const CachedImage(
      this.imageUrl, {
        this.isRound = false,
        this.radius = 0,
        this.height,
        this.width,
        this.fit = BoxFit.cover,
        this.useOldImageOnUrlChange = false,
        this.noPlaceHolder = false,
      });

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {

  Widget _getChild() {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      fit: widget.fit,
      useOldImageOnUrlChange: widget.useOldImageOnUrlChange,
      placeholder: (context, url) => widget.noPlaceHolder
          ? const SizedBox.shrink()
          : const AdaptiveProgressIndicator(
        strokeWidth: 2,
      ),
      errorWidget: (context, url, error) {
        return Container(
          height: widget.isRound ? widget.radius : widget.height,
          width: widget.isRound ? widget.radius : widget.width,
          color: Colors.black,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isRound ? widget.radius : widget.height,
      width: widget.isRound ? widget.radius : widget.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: _getChild(),
      ),
    );
  }
}

class AdaptiveProgressIndicator extends StatelessWidget {
  final double? value;
  final double strokeWidth;

  const AdaptiveProgressIndicator({
    this.value,
    this.strokeWidth = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: const AlwaysStoppedAnimation<Color?>(Colors.white),
          value: value,
        ),
      ),
    );
  }
}