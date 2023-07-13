import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({required this.onTap, super.key});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12;
    final screenWidth = context.screenWidth;
    return Stack(
      children: [
        Align(
          child: Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
            color: Colors.white,
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                ),
                height: 56,
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 3),
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: 2,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Войти',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  width: 6,
                ),
                SvgPicture.asset(AppImages.shikimoriLogo),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
