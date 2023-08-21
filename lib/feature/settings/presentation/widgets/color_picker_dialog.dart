import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/theme/theme_provider.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';

///Color picker alert dialog
class ColorPickerDialog extends StatelessWidget {
  ///Constructor
  const ColorPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    var chosenColor = Colors.white;
    return AlertDialog(
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      title: const Text(
        'Выберите цвет',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlidePicker(
            sliderSize: Size(MediaQuery.of(context).size.width, 40),
            enableAlpha: false,
            pickerColor: theme.colorScheme.primary,
            onColorChanged: (Color value) => chosenColor = value,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ThemeProvider>().changeToUserTheme(
                    chosenColor,
                    brightness: theme.brightness,
                  );
              context.pop();
            },
            child: const Text('Выбрать'),
          )
        ],
      ),
    );
  }
}
