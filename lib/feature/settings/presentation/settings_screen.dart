import 'package:flutter/material.dart';
import 'package:shikimoriapp/common/widgets/custom_app_bar.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/feature/settings/presentation/widgets/color_picker_dialog.dart';
import 'package:shikimoriapp/feature/settings/presentation/widgets/settings_block_widget.dart';
import 'package:shikimoriapp/feature/settings/presentation/widgets/settings_header_widget.dart';

///Settings screen
class SettingsScreen extends StatelessWidget {
  ///Default constructor
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final double spaceBetweenBlocks = 12;

    return Scaffold(
      appBar: CustomAppBar(
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
                  const SettingsHeaderWidget(text: 'Оформление asdasdas'),
                  SettingsBlockWidget(
                    text: 'Основной цвет',
                    leading: SizedBox(
                      height: 30,
                      width: 30,
                      child: GestureDetector(
                        onTap: () => showDialog(
                          builder: (context) => const ColorPickerDialog(),
                          context: context,
                        ),
                        child: ColoredBox(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: spaceBetweenBlocks,
                  ),
                  const SettingsHeaderWidget(text: 'Обновление'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
