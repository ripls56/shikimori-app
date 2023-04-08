import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shikimoriapp/core/helpers/images.dart';

///Loading with lottie animation
class CustomLoadingBar extends StatelessWidget {
  const CustomLoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppImages.loadingAnimation,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
      ),
    );
  }
}
