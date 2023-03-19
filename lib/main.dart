import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/data/repository/anime_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/creditional_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/user_auth_repository_impl.dart';
import 'package:shikimoriapp/feature/domain/use_cases/access_token/get_access_token.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_anime_by_id.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_animes.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_videos.dart';
import 'package:shikimoriapp/feature/domain/use_cases/creditional/get_creditional.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/videos/videos_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/home/profile_cubit.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/controller/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginScreenCubit>(
          create: ((context) =>
              LoginScreenCubit(GetAccessToken(GetAccessTokenRepositoryImpl()))),
        ),
        BlocProvider(
          create: ((context) => AnimeCubit(GetAnimes(AnimeRepositoryImpl()))),
        ),
        BlocProvider<ProfileCubit>(
          create: ((context) =>
              ProfileCubit(GetCreditional(CreditionalRepositoryImpl()))),
        ),
        BlocProvider<AnimeDetailCubit>(
          create: ((context) =>
              AnimeDetailCubit(GetAnimeById(AnimeRepositoryImpl()))),
        ),
        BlocProvider<VideosCubit>(
          create: ((context) => VideosCubit(GetVideos(AnimeRepositoryImpl()))),
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
