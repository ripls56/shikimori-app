import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/credential/credential_store.dart';
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
  final Uri _settingsPath =
      Uri(path: '${ScreenRoutes.home.path}${ScreenRoutes.settings.path}');

  final Uri _loginPath = Uri(path: ScreenRoutes.login.path);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: ColoredBox(
        color: Color.lerp(
              theme.colorScheme.background,
              theme.colorScheme.primary,
              0.1,
            ) ??
            theme.colorScheme.background,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Observer(
                      builder: (context) {
                        final userCredential =
                            context.read<CredentialStore>().userCredential;
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
                    const Align(
                      alignment: Alignment.topRight,
                      child: ChangeThemeWidget(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: theme.colorScheme.background,
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () => context.go(
                            _settingsPath.toString(),
                          ),
                          leading: const Icon(Icons.settings),
                          title: Text(
                            'Настройки',
                            style: theme.textTheme.bodyMedium,
                          ),
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
                                        child: CircularProgressIndicator
                                            .adaptive(),
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
                    ),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 200.ms),
        ),
      ),
    );
  }
}
