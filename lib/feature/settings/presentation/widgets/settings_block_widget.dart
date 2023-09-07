import 'package:flutter/material.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/feature/settings/presentation/widgets/color_picker_dialog.dart';

///Settings block
class SettingsBlockWidget extends StatelessWidget {
  ///Constructor
  const SettingsBlockWidget({
    required this.text,
    super.key,
    this.color,
    this.title, this.leading,
  });

  final Color? color;

  final String text;

  final String? title;

  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final mainTextStyle = theme.textTheme.titleMedium;
    final textStyle = theme.textTheme.labelMedium?.copyWith(color: Colors.grey);

    return ColoredBox(
      color: theme.colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: mainTextStyle,
                    ),
                    if (title != null)
                      Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            title!,
                            style: textStyle,
                          ),
                        ],
                      ),
                  ],
                ),
                leading ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
