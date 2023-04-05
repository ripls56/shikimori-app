import 'package:shikimoriapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/feature/data/datasources/anime/anime_remote_data_source.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/repositories/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeRemoteDataSource animeRemoteDataSource;

  AnimeRepositoryImpl(this.animeRemoteDataSource);
  @override
  Future<Either<Failure, AnimeDetails>> getAnimeById(int id) async {
    return await _getAnimeById(() => animeRemoteDataSource.getAnimeById(id));
  }

  @override
  Future<Either<Failure, List<Anime>>> getAnimes(int page,
      {String? order = "ranked", int? limit = 50, int? score}) async {
    return await _getAnimes(() => animeRemoteDataSource.getAnimes(page,
        order: order, limit: limit, score: score));
  }

  Future<Either<Failure, AnimeDetails>> _getAnimeById(
      Future<AnimeDetails> Function() anime) async {
    try {
      final model = await anime();
      return Right(model);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Anime>>> _getAnimes(
      Future<List<Anime>> Function() animes) async {
    try {
      final model = await animes();
      return Right(model);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Video>>> getVideos(int id) async {
    return await _getVideos(() => animeRemoteDataSource.getVideos(id));
  }

  Future<Either<Failure, List<Video>>> _getVideos(
      Future<List<Video>> Function() videos) async {
    try {
      final model = await videos();
      return Right(model);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Screenshot>>> getScreenshots(int id) async {
    return await _getScreenshots(
        () => animeRemoteDataSource.getScreenshots(id));
  }

  Future<Either<Failure, List<Screenshot>>> _getScreenshots(
      Future<List<Screenshot>> Function() screenshots) async {
    try {
      final model = await screenshots();
      return Right(model);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, List<Related>>> getRelated(int id) async {
  //   return await _getRelated(() => animeRemoteDataSource.getRelatedAnime(id));
  // }

  // Future<Either<Failure, List<Related>>> _getRelated(
  //     Future<List<Related>> Function() relateds) async {
  //   try {
  //     final model = await relateds();
  //     return Right(model);
  //   } catch (_) {
  //     return Left(ServerFailure());
  //   }
  // }

  @override
  Future<Either<Failure, List<Anime>>> getAnimesByName(String phrase,
      {String? order = "ranked", int? limit = 50, int? score}) async {
    return await _getAnimesByName(
      () => animeRemoteDataSource.getAnimesByName(phrase,
          order: order, limit: limit, score: score),
    );
  }

  Future<Either<Failure, List<Anime>>> _getAnimesByName(
      Future<List<Anime>> Function() animes) async {
    try {
      final model = await animes();
      return Right(model);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
