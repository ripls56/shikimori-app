import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

///Anime repository
abstract class AnimeRepository {
  ///Get anime list with page
  Future<Either<Failure, List<Anime>>> getAnimes(
    int page, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
  });

  ///Search anime by name
  Future<Either<Failure, List<Anime>>> getAnimesByName(
    String phrase, {
    int? limit = 50,
  });
}
