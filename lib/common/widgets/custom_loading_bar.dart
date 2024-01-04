import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';

///Loading with lottie animation
class CustomLoadingIndicator extends StatelessWidget {
  ///Constructor
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = MediaQuery.of(context).size;
    return Center(
      child: theme.brightness == Brightness.dark
          ? SvgPicture.asset(
              AppAssets.shikimoriLogo,
        color: theme.brightness != Brightness.dark ? Colors.black : Colors.white,
              width: 56,
              height: 56,
            )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .then()
              .tint(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 700),
                color: Colors.white,
              )
              .tint(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 700),
                color: context.theme.colorScheme.primary.withOpacity(.5),
              )
              .then()
              .tint(
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 700),
                color: Colors.white,
              )
          : Lottie.asset(
              AppAssets.loadingAnimationLight,
              width: size.width / 2,
              height: size.width / 2,
            ),
    );
  }
}
