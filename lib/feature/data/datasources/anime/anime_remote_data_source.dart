import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';

abstract class AnimeRemoteDataSource {
  ///Get anime list with page
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Anime>> getAnimes(int page,
      {String? order = "ranked", int? limit = 50, int? score});

  ///Get anime details with id
  ///
  ///Throws [ServerException] for all code errors
  Future<AnimeDetails> getAnimeById(int id);

  ///Get anime videos with id
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Video>> getVideos(int id);

  ///Get anime screenshots with id
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Screenshot>> getScreenshots(int id);

  ///Get related with id
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Related>> getRelatedAnime(int id);
}
