import 'package:shikimori_app/feature/domain/entities/anime/anime.dart';
import 'package:shikimori_app/feature/domain/entities/anime_details/anime_details.dart';

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
}
