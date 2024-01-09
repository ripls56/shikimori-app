import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

/// Widget to display a button with a headline
@immutable
class HeadlineButton extends StatelessWidget {
  /// Constructor
  HeadlineButton({
    required this.label,
    required this.onTap,
    this.child,
    super.key,
    this.height,
    this.headlineTextStyle,
    this.padding,
  });

  /// Title of the button
  final String label;

  /// Child of the button witch will be displayed on the bottom and
  /// also clickable
  final Widget? child;

  /// Height of the button
  final double? height;

  /// Function to call when the button is pressed
  final void Function() onTap;

  ///Text style for title
  final TextStyle? headlineTextStyle;

  ///Padding for title
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (Platform.isIOS)
          _CupertinoHeadlineButton(
            onTap: onTap,
            label: label,
            padding: padding,
            headlineTextStyle: headlineTextStyle,
          )
        else
          _MaterialHeadlineButton(
            onTap: onTap,
            label: label,
            padding: padding,
            headlineTextStyle: headlineTextStyle,
          ),
        ColoredBox(
          color: theme.colorScheme.background,
          child: child,
        ),
      ],
    );
  }
}

class _CupertinoHeadlineButton extends StatelessWidget {
  const _CupertinoHeadlineButton({
    required this.onTap,
    required this.label,
    super.key,
    this.headlineTextStyle,
    this.padding,
  });

  final VoidCallback onTap;

  final String label;

  final TextStyle? headlineTextStyle;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CupertinoButton(
      color: theme.colorScheme.background,
      borderRadius: BorderRadius.zero,
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 18,
          ),
      onPressed: onTap,
      child: Row(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: headlineTextStyle ?? theme.textTheme.headlineSmall,
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.right_chevron,
            size: 18,
            color: theme.colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}

class _MaterialHeadlineButton extends StatelessWidget {
  const _MaterialHeadlineButton({
    required this.onTap,
    required this.label,
    super.key,
    this.headlineTextStyle,
    this.padding,
  });

  final VoidCallback onTap;

  final String label;

  final TextStyle? headlineTextStyle;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      color: theme.colorScheme.background,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 18,
              ),
          child: Row(
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: headlineTextStyle ?? theme.textTheme.headlineSmall,
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
