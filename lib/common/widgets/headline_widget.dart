import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

class HeadlineWidget extends StatelessWidget {
  HeadlineWidget({required this.title, super.key, this.height});

  final String title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      height: height ?? 34,
      color: theme.colorScheme.primaryContainer.withOpacity(.7),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: height,
              color: theme.colorScheme.primary,
              width: 10,
            ),
          ),
        ],
      ),
    );
  }
}
