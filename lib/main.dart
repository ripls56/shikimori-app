import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/core/helpers/screen_routes.dart';
import 'package:shikimoriapp/core/theme/theme_provider.dart';
import 'package:shikimoriapp/feature/anime/presentation/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/anime/presentation/view/anime/anime_screen.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/screenshots/screenshots_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/videos/videos_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/anime_details.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/authorization/presentation/view/login_screen.dart';
import 'package:shikimoriapp/feature/character/presentation/controller/character_cubit.dart';
import 'package:shikimoriapp/feature/character/presentation/view/character_screen.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home/home_store.dart';
import 'package:shikimoriapp/feature/home/presentation/view/home_screen.dart';
import 'package:shikimoriapp/feature/profile/presentation/controller/profile_cubit.dart';
import 'package:shikimoriapp/feature/search/presentation/bloc/search_bloc.dart';
import 'package:shikimoriapp/feature/settings/presentation/settings_screen.dart';
import 'package:shikimoriapp/firebase_options.dart';
import 'package:shikimoriapp/injection.container.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    sl<Talker>().handle(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    sl<Talker>().handle(error, stack);
    return true;
  };

  await runZonedGuarded(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    Animate.restartOnHotReload = true;
    await init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  }, (error, stack) {
    sl<Talker>().handle(error, stack);
  });
}

///Set frame rate to 120Hz if device support it
Future<void> _frameRate() async {
  try {
    await FlutterDisplayMode.setHighRefreshRate();
  } catch (_) {
    await FlutterDisplayMode.setLowRefreshRate();
  }
}

///Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _frameRate();
    return MultiBlocProvider(
      providers: [
        Provider(
          create: (context) => sl<Talker>(),
        ),
        BlocProvider<LoginScreenCubit>(
          create: (context) => sl<LoginScreenCubit>(),
        ),
        BlocProvider<AnimePageCubit>(
          create: (context) => sl<AnimePageCubit>(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => sl<ProfileCubit>(),
        ),
        BlocProvider<AnimeDetailCubit>(
          create: (context) => sl<AnimeDetailCubit>(),
        ),
        BlocProvider<VideosCubit>(
          create: (context) => sl<VideosCubit>(),
        ),
        BlocProvider<ScreenshotsCubit>(
          create: (context) => sl<ScreenshotsCubit>(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => sl<SearchBloc>(),
        ),
        BlocProvider<CharacterCubit>(
          create: (context) => sl<CharacterCubit>(),
        ),
      ],
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (_) => sl<ThemeProvider>(),
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) => MaterialApp.router(
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: context.read<ThemeProvider>().appTheme,
          ),
        ),
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: ScreenRoutes.login,
      path: '/login',
      builder: (context, state) => Provider(
        create: (context) => sl<Talker>(),
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
          path: ScreenRoutes.anime,
          builder: (context, state) {
            final order = state.uri.queryParameters['order'];
            final limit = int.parse(state.uri.queryParameters['limit'] ?? '0');
            final score = int.parse(state.uri.queryParameters['score'] ?? '0');
            final season = state.uri.queryParameters['season'];
            final status = state.uri.queryParameters['status'];
            return MultiProvider(
              providers: [],
              builder: (context, child) => AnimeScreen(
                order: order,
                limit: limit,
                score: score,
                season: season,
                status: status,
              ),
            );
          },
        ),
        GoRoute(
          path: ScreenRoutes.animeDetails,
          builder: (context, state) {
            final id = int.parse(state.uri.queryParameters['id'] ?? '0');
            return MultiProvider(
              providers: [],
              builder: (context, child) => AnimeDetailScreen(
                id: id,
              ),
            );
          },
        ),
        GoRoute(
          path: ScreenRoutes.characterDetails,
          builder: (context, state) {
            final id = int.parse(state.uri.queryParameters['id'] ?? '0');
            return MultiProvider(
              providers: [],
              builder: (context, child) => CharacterScreen(
                id: id,
              ),
            );
          },
        ),
      ],
    ),
  ],
);
