import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shikimoriapp/core/helpers/images.dart';

///Loading with lottie animation
class CustomLoadingBar extends StatelessWidget {
  const CustomLoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Lottie.asset(
        AppImages.loadingAnimation,
        width: size.width / 2,
        height: size.width / 2,
      ),
    );
  }
}
