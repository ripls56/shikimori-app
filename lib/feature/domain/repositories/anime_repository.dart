import 'package:dartz/dartz.dart';
import 'package:shikimori_app/core/error/failure.dart';
import 'package:shikimori_app/feature/domain/entities/anime/anime.dart';

abstract class AnimeRepository {
  ///Get anime list with page
  Future<Either<Failure, List<Anime>>> getAnimes(int page,
      {String? order = "ranked", int? limit = 50, int? score});

  ///Get anime details with id
  Future<Either<Failure, Anime>> getAnimeById(int id);
}
