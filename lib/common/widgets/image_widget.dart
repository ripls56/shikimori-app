import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/helpers/images.dart';

/// Widget to display an image from a url
class ImageWidget extends StatelessWidget {
  ///Constructor
  const ImageWidget({
    required this.url,
    super.key,
    this.fit,
    this.width,
    this.height,
  });

  ///Url of the image
  final String url;

  ///Fit of the image
  final BoxFit? fit;

  ///Width of the image
  final double? width;

  ///Height of the image
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 2,
        ),
      ),
      placeholderFadeInDuration: Duration.zero,
      errorWidget: (context, url, error) => Center(
        child: Image.asset(
          AppImages.missing,
        ),
      ),
    );
  }
}
