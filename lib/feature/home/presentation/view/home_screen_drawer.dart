import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/creditional/creditional_store.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home_drawer/home_drawer_store.dart';
import 'package:shikimoriapp/feature/home/presentation/widgets/drawer/change_theme_widget.dart';
import 'package:shikimoriapp/feature/home/presentation/widgets/drawer/credential_widget.dart';
import 'package:shikimoriapp/feature/home/presentation/widgets/drawer/exit_button.dart';
import 'package:shikimoriapp/feature/home/presentation/widgets/drawer/no_creditional_widget.dart';
import 'package:shikimoriapp/routes.dart';

///Home screen drawer
class HomeScreenDrawer extends StatefulWidget {
  ///Default constructor
  HomeScreenDrawer({super.key});

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer>
    with SingleTickerProviderStateMixin {
  final Uri _settingsPath = Uri(path: '/${ScreenRoutes.settings}');

  final Uri _loginPath = Uri(path: '/${ScreenRoutes.login}');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(ripls56): запровайдить [Creditional] после авторизация
    final theme = context.theme;
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: ColoredBox(
        color: theme.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ColoredBox(
              color: theme.colorScheme.primary.withOpacity(.1),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Observer(
                      builder: (context) {
                        final userCredential =
                            context.read<CreditionalStore>().userCreditional;
                        if (userCredential == null) {
                          return const NoCreditionalWidget();
                        } else {
                          return CredentialWidget(
                            profileImgUrl: userCredential.image.x160,
                            nickname: userCredential.nickname,
                            userProfileUrl: userCredential.url,
                          );
                        }
                      },
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).viewPadding.top,
                        ),
                        const ChangeThemeWidget(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () => context.go(
                _settingsPath.toString(),
              ),
              leading: const Icon(Icons.settings),
              title: const Text('Настройки'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ReactionBuilder(
                builder: (context) => reaction(
                  (_) => context.read<HomeDrawerStore>().isDeleted,
                  (value) {
                    if (value) {
                      context.go(_loginPath.toString());
                    }
                  },
                ),
                child: Observer(
                  builder: (context) {
                    final status = context
                        .read<HomeDrawerStore>()
                        .deleteTokensFuture
                        .status;
                    switch (status) {
                      case FutureStatus.pending:
                        return ElevatedButton(
                          onPressed: () {},
                          child: const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      case FutureStatus.fulfilled:
                        return const ExitButton();
                      case FutureStatus.rejected:
                        return const Icon(
                          Icons.close,
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 200.ms),
      ),
    );
  }
}
