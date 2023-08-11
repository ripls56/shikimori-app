import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

///Anime remote data source
abstract class AnimeRemoteDataSource {
  ///Get anime list with page
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Anime>> getAnimes(
    int page, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
    String? season,
    String? status,
  });

  ///Get animes by name
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Anime>> getAnimesByName(
    String phrase, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
  });
}
