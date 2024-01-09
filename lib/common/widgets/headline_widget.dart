import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

class HeadlineWidget extends StatelessWidget {
  HeadlineWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final lineColor = Color.lerp(
          theme.colorScheme.background,
          theme.colorScheme.primary,
          0.1,
        ) ??
        theme.colorScheme.background;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
