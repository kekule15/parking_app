
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  const SvgImage(
      {Key? key, required this.asset, this.height, this.color, this.width})
      : super(key: key);
  final String asset;
  final Color? color;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(asset, color: color, width: width, height: height);
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {Key? key, required this.asset, this.width, this.height, this.fit})
      : super(key: key);
  final String asset;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
