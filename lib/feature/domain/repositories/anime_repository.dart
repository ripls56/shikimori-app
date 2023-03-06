import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';

abstract class AnimeRepository {
  ///Get anime list with page
  Future<Either<Failure, List<Anime>>> getAnimes(int page,
      {String? order = "ranked", int? limit = 50, int? score});

  ///Get anime details with id
  Future<Either<Failure, AnimeDetails>> getAnimeById(int id);
}
