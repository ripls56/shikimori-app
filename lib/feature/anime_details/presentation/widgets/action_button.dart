import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shikimoriapp/common/theme/extensions/action_button_theme.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

///Button for main action on details screen
class ActionButton extends StatelessWidget {
  ///Constructor
  const ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  ///Label in bottom of button
  final String label;

  ///Icon
  final IconData icon;

  ///
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<ActionButtonTheme>();
    if (theme == null) {
      throw FlutterError('Action button theme must not be null');
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        HapticFeedback.lightImpact();
        onPressed.call();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: theme.iconColor,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              label,
              style: theme.labelTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
