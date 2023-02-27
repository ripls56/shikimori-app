import 'package:shikimori_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimori_app/feature/data/datasources/anime/anime_remote_data_source.dart';
import 'package:shikimori_app/feature/data/datasources/anime/anime_remote_data_source_impl.dart';
import 'package:shikimori_app/feature/domain/entities/anime_details/anime_details.dart';
import '../../domain/entities/anime/anime.dart';
import '../../domain/repositories/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  AnimeRemoteDataSource animeRemoteDataSource = AnimeRemoteDataSourceImpl();
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
}
