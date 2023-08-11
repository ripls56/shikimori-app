import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shikimoriapp/core/helpers/crashlitycs.dart';
import 'package:shikimoriapp/core/theme/theme_provider.dart';
import 'package:shikimoriapp/feature/anime/data/data_sources/anime_remote_data_source.dart';
import 'package:shikimoriapp/feature/anime/data/data_sources/anime_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/anime/data/repositories/anime_repository_impl.dart';
import 'package:shikimoriapp/feature/anime/domain/repositories/anime_repository.dart';
import 'package:shikimoriapp/feature/anime/domain/use_cases/get_anime_by_name.dart';
import 'package:shikimoriapp/feature/anime/domain/use_cases/get_animes.dart';
import 'package:shikimoriapp/feature/anime/presentation/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/data/data_sources/anime_details_remote_data_source.dart';
import 'package:shikimoriapp/feature/anime_details/data/data_sources/anime_details_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/anime_details/data/repositories/anime_details_repository_impl.dart';
import 'package:shikimoriapp/feature/anime_details/domain/repositories/anime_details_repository.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_anime_by_id.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_related.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_screenshots.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_videos.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/screenshots/screenshots_cubit.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/videos/videos_cubit.dart';
import 'package:shikimoriapp/feature/authorization/data/datasources/token_local_data_source.dart';
import 'package:shikimoriapp/feature/authorization/data/datasources/token_local_data_source_impl.dart';
import 'package:shikimoriapp/feature/authorization/data/datasources/user_auth_remote_data_source.dart';
import 'package:shikimoriapp/feature/authorization/data/datasources/user_auth_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/authorization/data/repositories/tokens_local_repository_impl.dart';
import 'package:shikimoriapp/feature/authorization/domain/repositories/tokens_repository.dart';
import 'package:shikimoriapp/feature/authorization/domain/repositories/user_auth_repository.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/delete_tokens.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token_from_storage.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_refresh_token_from_storage.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/refresh_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/save_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/save_refresh_token.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/character/data/datasources/character_remote_data_source.dart';
import 'package:shikimoriapp/feature/character/data/datasources/character_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/character/data/repositories/character_repository_impl.dart';
import 'package:shikimoriapp/feature/character/domain/repositories/character_repository.dart';
import 'package:shikimoriapp/feature/character/domain/use_cases/get_character_by_id.dart';
import 'package:shikimoriapp/feature/character/presentation/controller/character_cubit.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home/home_store.dart';
import 'package:shikimoriapp/feature/profile/data/datasources/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/profile/data/datasources/creditional_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/profile/data/repositories/creditional_repository_impl.dart';
import 'package:shikimoriapp/feature/profile/data/repositories/user_auth_repository_impl.dart';
import 'package:shikimoriapp/feature/profile/domain/repositories/creditional_repository.dart';
import 'package:shikimoriapp/feature/profile/domain/use_cases/get_creditional.dart';
import 'package:shikimoriapp/feature/profile/presentation/controller/profile_cubit.dart';
import 'package:shikimoriapp/feature/related/data/datasources/related_remote_data_source.dart';
import 'package:shikimoriapp/feature/related/data/datasources/related_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/related/data/repositories/related_repository_impl.dart';
import 'package:shikimoriapp/feature/related/domain/repositories/related_repository.dart';
import 'package:shikimoriapp/feature/search/presentation/bloc/search_bloc.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

///Service locator
final sl = GetIt.asNewInstance();

///Init service locator
Future<void> init() async {
  //Talker
  sl.registerLazySingleton(CrashlyticsTalkerObserver.new);

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

  //Theme
  sl.registerLazySingleton(() => ThemeProvider());

  //Stores
  sl.registerFactory(() => HomeStore(sl()));

  //Cubit
  sl.registerFactory(() => AnimePageCubit(sl()));
  sl.registerFactory(() => VideosCubit(sl()));
  sl.registerFactory(() => ProfileCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AnimeDetailCubit(sl(), sl()));
  sl.registerFactory(() => LoginScreenCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ScreenshotsCubit(sl()));
  sl.registerFactory(() => SearchBloc(sl()));
  sl.registerFactory(() => CharacterCubit(sl()));

  //UseCases
  sl.registerLazySingleton(() => GetAnimes(sl()));
  sl.registerLazySingleton(() => DeleteTokens(sl()));
  sl.registerLazySingleton(() => SaveAccessToken(sl()));
  sl.registerLazySingleton(() => SaveRefreshToken(sl()));
  sl.registerLazySingleton(() => GetAccessTokenFromStorage(sl()));
  sl.registerLazySingleton(() => GetRefreshTokenFromStorage(sl()));
  sl.registerLazySingleton(() => GetVideos(sl()));
  sl.registerLazySingleton(() => GetCreditional(sl()));
  sl.registerLazySingleton(() => GetAnimeById(sl()));
  sl.registerLazySingleton(() => GetCharacterById(sl()));
  sl.registerLazySingleton(() => GetAnimeByName(sl()));
  sl.registerLazySingleton(() => GetRelatedAnimes(sl()));
  sl.registerLazySingleton(() => GetAccessToken(sl()));
  sl.registerLazySingleton(() => RefreshAccessToken(sl()));
  sl.registerLazySingleton(() => GetScreenshots(sl()));

  //Repositories
  sl.registerLazySingleton<AnimeRepository>(() => AnimeRepositoryImpl(sl()));
  sl.registerLazySingleton<CreditionalRepository>(
    () => CreditionalRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AnimeDetailsRepository>(
    () => AnimeDetailsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<UserAuthRepository>(
    () => UserAuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<RelatedRepository>(
    () => RelatedRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TokenLocalRepository>(
    () => TokensLocalRepositoryImpl(sl()),
  );

  //RemoteDataSource
  sl.registerLazySingleton<AnimeRemoteDataSource>(
    () => AnimeRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AnimeDetailsRemoteDataSource>(
    () => AnimeDetailsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CreditionalRemoteDataSource>(
    () => CreditionalRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserAuthRemoteDataSource>(
    () => UserAuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<RelatedRemoteDataSource>(
    () => RelatedRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(sl()),
  );

  //LocalDataSource
  sl.registerLazySingleton<TokenLocalDataSource>(
    () => TokenLocalDataSourceImpl(sl()),
  );
}
