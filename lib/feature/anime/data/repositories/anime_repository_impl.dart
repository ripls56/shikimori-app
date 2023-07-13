import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/anime/data/data_sources/anime_remote_data_source.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime/domain/repositories/anime_repository.dart';

///Anime repository implementation
class AnimeRepositoryImpl implements AnimeRepository {
  ///Anime repository implementation
  const AnimeRepositoryImpl(this._animeRemoteDataSource);
  final AnimeRemoteDataSource _animeRemoteDataSource;

  @override
  Future<Either<Failure, List<Anime>>> getAnimesByName(
    String phrase, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
  }) async {
    return _getAnimesByName(
      () => _animeRemoteDataSource.getAnimesByName(
        phrase,
        order: order,
        limit: limit,
        score: score,
      ),
    );
  }

  Future<Either<Failure, List<Anime>>> _getAnimesByName(
    Future<List<Anime>> Function() animes,
  ) async {
    try {
      final model = await animes();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> getAnimes(
    int page, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
  }) async {
    return _getAnimes(
      () => _animeRemoteDataSource.getAnimes(
        page,
        order: order,
        limit: limit,
        score: score,
      ),
    );
  }

  Future<Either<Failure, List<Anime>>> _getAnimes(
    Future<List<Anime>> Function() animes,
  ) async {
    try {
      final model = await animes();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
