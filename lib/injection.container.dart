import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shikimoriapp/core/helpers/crashlitycs.dart';
import 'package:shikimoriapp/feature/data/datasources/anime/anime_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/anime/anime_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/datasources/character/character_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/character/character_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/datasources/related/related_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/related/related_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/datasources/token/token_local_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/token/token_local_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/repository/anime_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/character_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/creditional_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/refresh_token_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/related_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/tokens_local_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/user_auth_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/user_auth_repository_impl.dart';
import 'package:shikimoriapp/feature/domain/repositories/anime_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/character_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/creditional_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/refresh_access_token_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/related_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/tokens_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/user_auth_repository.dart';
import 'package:shikimoriapp/feature/domain/use_cases/access_token/get_access_token.dart';
import 'package:shikimoriapp/feature/domain/use_cases/access_token/refresh_access_token.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_anime_by_id.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_anime_by_name.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_animes.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_related.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_screenshots.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_videos.dart';
import 'package:shikimoriapp/feature/domain/use_cases/character/get_character_by_id.dart';
import 'package:shikimoriapp/feature/domain/use_cases/creditional/get_creditional.dart';
import 'package:shikimoriapp/feature/domain/use_cases/save_tokens/save_access_token.dart';
import 'package:shikimoriapp/feature/domain/use_cases/save_tokens/save_refresh_token.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/screenshots/screenshots_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/videos/videos_cubit.dart';
import 'package:shikimoriapp/feature/presentation/character_screen/controller/character_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/home/profile_cubit.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/controller/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/presentation/search/bloc/search_bloc.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  //Talker
  sl.registerLazySingleton(() => CrashlyticsTalkerObserver());
  final talker = TalkerFlutter.init(
    observer: sl<CrashlyticsTalkerObserver>(),
  );
  sl.registerLazySingleton(() => talker);

  //Dio
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: sl<Talker>(),
    ),
  );
  dio.options.headers = {
    'User-Agent': 'mpt coursework',
  };

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  sl.registerLazySingleton(() => dio);

  sl.registerLazySingleton(() => storage);

  //Cubit
  sl.registerFactory(() => AnimePageCubit(sl()));
  sl.registerFactory(() => VideosCubit(sl()));
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerFactory(() => AnimeDetailCubit(sl(), sl()));
  sl.registerFactory(() => LoginScreenCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ScreenshotsCubit(sl()));
  sl.registerFactory(() => SearchBloc(sl()));
  sl.registerFactory(() => CharacterCubit(sl()));

  //UseCases
  sl.registerLazySingleton(() => GetAnimes(sl()));
  sl.registerLazySingleton(() => GetVideos(sl()));
  sl.registerLazySingleton(() => GetCreditional(sl()));
  sl.registerLazySingleton(() => GetAnimeById(sl()));
  sl.registerLazySingleton(() => GetCharacterById(sl()));
  sl.registerLazySingleton(() => GetAnimeByName(sl()));
  sl.registerLazySingleton(() => GetRelatedAnimes(sl()));
  sl.registerLazySingleton(() => GetAccessToken(sl()));
  sl.registerLazySingleton(() => RefreshAccessToken(sl()));
  sl.registerLazySingleton(() => GetScreenshots(sl()));
  sl.registerLazySingleton(() => SaveAccessToken(sl()));
  sl.registerLazySingleton(() => SaveRefreshToken(sl()));

  //Repositories
  sl.registerLazySingleton<AnimeRepository>(() => AnimeRepositoryImpl(sl()));
  sl.registerLazySingleton<CreditionalRepository>(
      () => CreditionalRepositoryImpl(sl()));
  sl.registerLazySingleton<UserAuthRepository>(
      () => GetAccessTokenRepositoryImpl(sl()));
  sl.registerLazySingleton<RefreshAccessTokenRepository>(
      () => UserAuthRepositoryImpl(sl()));
  sl.registerLazySingleton<RelatedRepository>(
      () => RelatedRepositoryImpl(sl()));
  sl.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(sl()));
  sl.registerLazySingleton<SaveAccessTokenRepository>(
      () => TokensLocalRepositoryImpl(sl()));
  sl.registerLazySingleton<SaveRefreshTokenRepository>(
      () => SaveRefreshTokenRepositoryImpl(sl()));

  //RemoteDataSource
  sl.registerLazySingleton<AnimeRemoteDataSource>(
      () => AnimeRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CreditionalRemoteDataSource>(
      () => CreditionalRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<UserAuthRemoteDataSource>(
      () => UserAuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<RelatedRemoteDataSource>(
      () => RelatedRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl(sl()));

  //LocalDataSource
  sl.registerLazySingleton<TokenLocalDataSource>(
      () => TokenLocalDataSourceImpl(sl()));
}
