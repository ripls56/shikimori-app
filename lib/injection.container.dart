import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimoriapp/feature/data/datasources/anime/anime_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/anime/anime_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/datasources/related/related_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/related/related_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source_impl.dart';
import 'package:shikimoriapp/feature/data/repository/anime_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/creditional_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/related_repository_impl.dart';
import 'package:shikimoriapp/feature/data/repository/user_auth_repository_impl.dart';
import 'package:shikimoriapp/feature/domain/repositories/access_token_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/anime_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/creditional_repository.dart';
import 'package:shikimoriapp/feature/domain/repositories/related_repository.dart';
import 'package:shikimoriapp/feature/domain/use_cases/access_token/get_access_token.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_anime_by_id.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_anime_by_name.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_animes.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_related.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_screenshots.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_videos.dart';
import 'package:shikimoriapp/feature/domain/use_cases/creditional/get_creditional.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/details/anime_detail_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/screenshots/screenshots_cubit.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/videos/videos_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/home/profile_cubit.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/controller/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/presentation/search/controller/search_cubit.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  //Dio
  final dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
  dio.options.headers = {
    'User-Agent': 'mpt coursework',
  };
  sl.registerLazySingleton(() => dio);

  //Cubit
  sl.registerFactory(() => AnimePageCubit(sl()));
  sl.registerFactory(() => VideosCubit(sl()));
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerFactory(() => AnimeDetailCubit(sl(), sl()));
  sl.registerFactory(() => LoginScreenCubit(sl()));
  sl.registerFactory(() => ScreenshotsCubit(sl()));
  sl.registerFactory(() => SearchCubit(sl()));

  //UseCases
  sl.registerLazySingleton(() => GetAnimes(sl()));
  sl.registerLazySingleton(() => GetVideos(sl()));
  sl.registerLazySingleton(() => GetCreditional(sl()));
  sl.registerLazySingleton(() => GetAnimeById(sl()));
  sl.registerLazySingleton(() => GetAnimeByName(sl()));
  sl.registerLazySingleton(() => GetRelatedAnimes(sl()));
  sl.registerLazySingleton(() => GetAccessToken(sl()));
  sl.registerLazySingleton(() => GetScreenshots(sl()));

  //Repositories
  sl.registerLazySingleton<AnimeRepository>(() => AnimeRepositoryImpl(sl()));
  sl.registerLazySingleton<CreditionalRepository>(
      () => CreditionalRepositoryImpl(sl()));
  sl.registerLazySingleton<GetAccessTokenRepository>(
      () => GetAccessTokenRepositoryImpl(sl()));
  sl.registerLazySingleton<RelatedRepository>(
      () => RelatedRepositoryImpl(sl()));

  //DataSource
  sl.registerLazySingleton<AnimeRemoteDataSource>(
      () => AnimeRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CreditionalRemoteDataSource>(
      () => CreditionalRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<UserAuthRemoteDataSource>(
      () => UserAuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<RelatedRemoteDataSource>(
      () => RelatedRemoteDataSourceImpl(sl()));

  //
}
