import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/feature/anime/presentation/view/anime/anime_screen.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/anime_details.dart';
import 'package:shikimoriapp/feature/authorization/domain/models/user_auth.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/login/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/token/token_store.dart';
import 'package:shikimoriapp/feature/authorization/presentation/view/login_screen.dart';
import 'package:shikimoriapp/feature/authorization/presentation/view/token_screen.dart';
import 'package:shikimoriapp/feature/character/presentation/view/character_screen.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home/home_store.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home_drawer/home_drawer_store.dart';
import 'package:shikimoriapp/feature/home/presentation/view/home_screen.dart';
import 'package:shikimoriapp/feature/settings/presentation/settings_screen.dart';
import 'package:shikimoriapp/feature/update_app/presentation/update_screen.dart';
import 'package:shikimoriapp/injection.container.dart';

/// [ScreenRoutes] class defines static getters to retrieve instances
/// of the [ScreenRoute].
/// Each method returns a unique route with
/// a specified 'name' and 'path'.
abstract class ScreenRoutes {
  ///[LoginScreen] route
  static ScreenRoute get login => ScreenRoute(
        name: 'login',
        path: '/login',
      );

  ///[HomeScreen] route
  static ScreenRoute get home => ScreenRoute(
        name: 'home',
        path: '/',
      );

  ///[SettingsScreen] route
  static ScreenRoute get settings => ScreenRoute(
        name: 'settings',
        path: 'settings',
      );

  ///[UpdateScreen] route
  static ScreenRoute get update => ScreenRoute(
        name: 'update',
        path: 'update',
      );

  ///[AnimeScreen] route
  static ScreenRoute get anime => ScreenRoute(
        name: 'animes',
        path: 'animes',
      );

  ///[AnimeDetailScreen] route
  static ScreenRoute get animeDetails => ScreenRoute(
        name: 'anime_details',
        path: 'anime_details',
      );

  ///[CharacterScreen] route
  static ScreenRoute get characterDetails => ScreenRoute(
        name: 'character_details',
        path: 'character_details',
      );
}

/// The [ScreenRoute] class represents a model
/// for defining routes in the application.
class ScreenRoute {
  ///Constructor
  ScreenRoute({required this.name, required this.path});

  ///Route name
  final String name;

  ///Route path
  final String path;
}

///Go router paths
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: ScreenRoutes.login.name,
      path: ScreenRoutes.login.path,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<LoginScreenCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/token',
      redirect: (context, state) {
        if (state.uri.queryParameters.isEmpty) {
          return ScreenRoutes.login.path;
        }
        return null;
      },
      builder: (context, state) => Provider(
        create: (context) => sl<TokenStore>(),
        child: TokenScreen(
          code: state.uri.queryParameters['code']!,
        ),
      ),
    ),
    GoRoute(
      name: ScreenRoutes.home.name,
      path: ScreenRoutes.home.path,
      builder: (context, state) => MultiProvider(
        providers: [
          Provider(
            create: (context) => sl<HomeStore>(),
          ),
          Provider(
            create: (context) => sl<HomeDrawerStore>(),
          ),
          if (state.extra != null)
            Provider(
              create: (context) => state.extra! as UserAuth,
            ),
        ],
        builder: (context, child) => const HomeScreen(),
      ),
      routes: [
        GoRoute(
          name: ScreenRoutes.settings.name,
          path: ScreenRoutes.settings.path,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: ScreenRoutes.update.path,
          builder: (context, state) => const UpdateScreen(),
        ),
        GoRoute(
          name: ScreenRoutes.anime.name,
          path: ScreenRoutes.anime.path,
          builder: (context, state) {
            final order = state.uri.queryParameters['order'];
            final limit = int.parse(state.uri.queryParameters['limit'] ?? '0');
            final score = int.parse(state.uri.queryParameters['score'] ?? '0');
            final season = state.uri.queryParameters['season'];
            final status = state.uri.queryParameters['status'];
            return AnimeScreen(
              order: order,
              limit: limit,
              score: score,
              season: season,
              status: status,
            );
          },
        ),
        GoRoute(
          name: ScreenRoutes.animeDetails.name,
          path: ScreenRoutes.animeDetails.path,
          builder: (context, state) {
            final id = int.parse(state.uri.queryParameters['id'] ?? '0');
            return AnimeDetailScreen(
              id: id,
            );
          },
        ),
        GoRoute(
          name: ScreenRoutes.characterDetails.name,
          path: ScreenRoutes.characterDetails.path,
          builder: (context, state) {
            final id = int.parse(state.uri.queryParameters['id'] ?? '0');
            return CharacterScreen(
              id: id,
            );
          },
        ),
      ],
    ),
  ],
);
