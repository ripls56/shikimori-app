import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

class SettingsHeaderWidget extends StatelessWidget {
  const SettingsHeaderWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: Text(
        text,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
