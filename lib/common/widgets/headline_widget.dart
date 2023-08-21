import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

class HeadlineWidget extends StatelessWidget {
  HeadlineWidget({required this.title, super.key, this.height = 30});

  final String title;
  double? height;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      height: height,
      color: theme.colorScheme.primaryContainer.withOpacity(.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge,
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
