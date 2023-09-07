import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home_drawer/home_drawer_store.dart';

///Exit drawer button
class ExitButton extends StatelessWidget {
  ///Constructor
  const ExitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
