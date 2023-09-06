import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';

class NoCreditionalWidget extends StatelessWidget {
  const NoCreditionalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).viewPadding.top,
        ),
        CircleAvatar(
          radius: 30,
          foregroundImage: Image.asset(AppAssets.missing).image,
        ),
        const SizedBox(height: 8),
        Text(
          'Username',
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}
