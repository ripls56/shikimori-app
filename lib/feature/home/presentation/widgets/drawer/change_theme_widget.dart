import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/theme/theme_provider.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

///Change theme icon button
class ChangeThemeWidget extends StatelessWidget {
  ///Constructor
  const ChangeThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return RepaintBoundary(
      child: Animate(
        onPlay: (controller) {
          controller.repeat(
            reverse: true,
          );
        },
        effects: [
          RotateEffect(
            curve: Curves.easeInOut,
            begin: theme.brightness == Brightness.dark ? 0 : pi / 0.86,
            end: theme.brightness == Brightness.dark ? pi / 8 : pi / 0.88,
            duration: theme.brightness == Brightness.dark ? 7000.ms : 2000.ms,
          ),
        ],
        child: Platform.isIOS
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(30),
                child: theme.brightness != Brightness.dark
                    ? const Icon(Icons.nightlight_outlined)
                    : const Icon(Icons.light_mode_outlined),
                onPressed: () => context.read<ThemeProvider>().changeTheme(),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                icon: theme.brightness != Brightness.dark
                    ? const Icon(Icons.nightlight_outlined)
                    : const Icon(Icons.light_mode_outlined),
                onPressed: () => context.read<ThemeProvider>().changeTheme(),
              ),
      ),
    );
  }
}
