import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home_drawer/home_drawer_store.dart';

///Exit drawer button
class ExitButton extends StatelessWidget {
  ///Constructor
  const ExitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return CupertinoButton(
          color: Color.lerp(
                theme.colorScheme.background,
                theme.colorScheme.primary,
                0.1,
              ) ??
              theme.colorScheme.background,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: theme.colorScheme.onSurface,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Выйти',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          onPressed: () {},
        );
      case TargetPlatform.android:
        return ElevatedButton.icon(
          onPressed: () {
            context.read<HomeDrawerStore>().deleteTokens();
          },
          icon: const Icon(
            Icons.exit_to_app,
          ),
          label: const Text('Выйти'),
        );
      case _:
        return ElevatedButton.icon(
          onPressed: () {
            context.read<HomeDrawerStore>().deleteTokens();
          },
          icon: const Icon(
            Icons.exit_to_app,
          ),
          label: const Text('Выйти'),
        );
    }
  }
}
