import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/feature/anime/presentation/view/anime/anime_screen.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/anime_details.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/login/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/authorization/presentation/view/login_screen.dart';
import 'package:shikimoriapp/feature/character/presentation/view/character_screen.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home/home_store.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home_drawer/home_drawer_store.dart';
import 'package:shikimoriapp/feature/home/presentation/view/home_screen.dart';
import 'package:shikimoriapp/feature/settings/presentation/settings_screen.dart';
import 'package:shikimoriapp/feature/update_app/presentation/update_screen.dart';
import 'package:shikimoriapp/injection.container.dart';

abstract class ScreenRoutes {
  static String get login => 'login';
  static String get home => 'home';
  static String get settings => 'settings';
  static String get update => 'update';
  static String get anime => 'animes';
  static String get animeDetails => 'anime_details';
  static String get characterDetails => 'character_details';
}

///Go router paths
final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: ScreenRoutes.login,
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (context) => sl<LoginScreenCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: ScreenRoutes.home,
      path: '/',
      builder: (context, state) => MultiProvider(
        providers: [
          Provider(
            create: (context) => sl<HomeStore>(),
          ),
          Provider(
            create: (context) => sl<HomeDrawerStore>(),
          ),
        ],
        builder: (context, child) => const HomeScreen(),
      ),
      routes: [
        GoRoute(
          name: ScreenRoutes.settings,
          path: ScreenRoutes.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: ScreenRoutes.update,
          builder: (context, state) => const UpdateScreen(),
        ),
        GoRoute(
          path: ScreenRoutes.anime,
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
          path: ScreenRoutes.animeDetails,
          builder: (context, state) {
            final id = int.parse(state.uri.queryParameters['id'] ?? '0');
            return AnimeDetailScreen(
              id: id,
            );
          },
        ),
        GoRoute(
          path: ScreenRoutes.characterDetails,
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
