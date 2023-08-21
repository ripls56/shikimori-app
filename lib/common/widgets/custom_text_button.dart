import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {required this.text, required this.onTap, super.key,
      this.color,
      this.textColor,});
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      color: color ?? Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
