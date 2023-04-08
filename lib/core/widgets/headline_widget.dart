import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {
  HeadlineWidget({super.key, required this.title, this.height = 30});

  final String title;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Theme.of(context).colorScheme.onBackground,
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
              color: Theme.of(context).colorScheme.surface.withOpacity(.5),
              width: 10,
            ),
          ),
        ],
      ),
    );
  }
}
