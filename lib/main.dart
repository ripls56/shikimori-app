import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/behaviours/scroll_without_splash.dart';
import 'package:shikimoriapp/common/theme/theme_provider.dart';
import 'package:shikimoriapp/core/helpers/snack_bar_service.dart';
import 'package:shikimoriapp/feature/anime/presentation/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/screenshots/screenshots_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/videos/videos_cubit.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/creditional/creditional_store.dart';
import 'package:shikimoriapp/feature/character/presentation/controller/character_cubit.dart';
import 'package:shikimoriapp/feature/profile/presentation/controller/profile_cubit.dart';
import 'package:shikimoriapp/feature/search/presentation/bloc/search_bloc.dart';
import 'package:shikimoriapp/firebase_options.dart';
import 'package:shikimoriapp/injection.container.dart';
import 'package:shikimoriapp/routes.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
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
    Bloc.observer = TalkerBlocObserver(talker: sl<Talker>());
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
        Provider(
          create: (context) => sl<CreditionalStore>(),
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
            routerConfig: router,
            scrollBehavior: ScrollWithoutSplash(),
            scaffoldMessengerKey: SnackBarService.scaffoldKey,
            debugShowCheckedModeBanner: false,
            title: 'shikimori app',
            theme: context.read<ThemeProvider>().appTheme,
          ),
        ),
      ),
    );
  }
}
