import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

@immutable

/// Widget to display a button with a headline
class HeadlineButton extends StatelessWidget {
  /// Constructor
  HeadlineButton({
    required this.title,
    required this.onPress,
    this.child,
    super.key,
    this.height,
  });

  /// Title of the button
  final String title;

  /// Child of the button witch will be displayed on the bottom and
  /// also clickable
  final Widget? child;

  /// Height of the button
  final double? height;

  /// Function to call when the button is pressed
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        Material(
          color: theme.colorScheme.primaryContainer.withOpacity(.5),
          child: InkWell(
            onTap: onPress,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: height ?? 38,
                    color: theme.colorScheme.primary,
                    width: 10,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_right,
                  ),
                )
              ],
            ),
          ),
        ),
        ColoredBox(
          color: theme.colorScheme.secondary,
          child: child,
        )
      ],
    );
  }
}
