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
    this.fadeInDuration,
    this.fadeOutDuration,
  });

  ///Url of the image
  final String url;

  ///Fit of the image
  final BoxFit? fit;

  ///Width of the image
  final double? width;

  ///Height of the image
  final double? height;

  ///The duration of the fade-in animation for the [url]
  final Duration? fadeInDuration;

  ///The duration of the fade-out animation for the [url]
  final Duration? fadeOutDuration;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      width: width,
      height: height,
      fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 200),
      fadeOutDuration: fadeOutDuration,
      progressIndicatorBuilder: (context, url, progress) => const Center(
        child: SizedBox.square(
          dimension: 26,
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      httpHeaders: const {
        'User-Agent': 'mpt coursework',
      },
      placeholderFadeInDuration: Duration.zero,
      errorWidget: (context, url, error) => Center(
        child: Image.asset(
          AppAssets.missing,
        ),
      ),
    );
  }
}
