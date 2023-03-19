import 'package:flutter/material.dart';

class HeadlineButton extends StatelessWidget {
  HeadlineButton(
      {super.key,
      required this.title,
      this.height,
      required this.onPress,
      required this.child});

  final String title;
  final Widget child;
  double? height = 30;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Theme.of(context).colorScheme.onBackground,
          child: InkWell(
            onTap: onPress,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.surface),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: height,
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(.5),
                    width: 10,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          color: Theme.of(context).colorScheme.inverseSurface,
          child: child,
        )
      ],
    );
  }
}
