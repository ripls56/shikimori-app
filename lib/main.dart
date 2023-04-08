import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/screenshots/screenshots_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/videos/videos_cubit.dart';
import 'package:shikimoriapp/feature/presentation/character_screen/controller/character_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/home/profile_cubit.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/controller/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/view/login_screen.dart';
import 'package:shikimoriapp/feature/presentation/search/controller/search_cubit.dart';
import 'injection.container.dart' as di;
import 'injection.container.dart';

Future<void> main() async {
  di.init();
  frameRate();
  runApp(const MyApp());
}

Future<void> frameRate() async {
  try {
    await FlutterDisplayMode.setHighRefreshRate();
  } catch (_) {
    await FlutterDisplayMode.setLowRefreshRate();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginScreenCubit>(
          create: ((context) => sl<LoginScreenCubit>()),
        ),
        BlocProvider<AnimePageCubit>(
          create: ((context) => sl<AnimePageCubit>()),
        ),
        BlocProvider<ProfileCubit>(
          create: ((context) => sl<ProfileCubit>()),
        ),
        BlocProvider<AnimeDetailCubit>(
          create: ((context) => sl<AnimeDetailCubit>()),
        ),
        BlocProvider<VideosCubit>(
          create: ((context) => sl<VideosCubit>()),
        ),
        BlocProvider<ScreenshotsCubit>(
          create: ((context) => sl<ScreenshotsCubit>()),
        ),
        BlocProvider<SearchCubit>(
          create: ((context) => sl<SearchCubit>()),
        ),
        BlocProvider<CharacterCubit>(
          create: ((context) => sl<CharacterCubit>()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder()
              }),
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              textTheme: TextTheme(
                  labelLarge: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 20))),
          home: const SafeArea(child: LoginScreen())),
    );
  }
}
