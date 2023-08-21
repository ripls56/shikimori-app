import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shikimoriapp/common/widgets/custom_app_bar.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/feature/settings/presentation/widgets/settings_block_widget.dart';

///Settings screen
class SettingsScreen extends StatelessWidget {
  ///Default constructor
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: 'Настройки',
      ),
      body: ListView(
        children: [
          ColoredBox(
            color: theme.brightness == Brightness.dark
                ? Colors.white.withOpacity(.075)
                : Colors.black.withOpacity(.075),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Text(
                      'Оформление',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const SettingsBlockWidget(
                    text: 'Основной цвет',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
