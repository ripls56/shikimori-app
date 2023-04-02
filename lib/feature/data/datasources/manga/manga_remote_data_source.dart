import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/entities/manga_details/manga_details.dart';

abstract class MangaRemoteDataSource {
  ///Get manga list with page
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Manga>> getAnimes(int page,
      {String? order = "ranked", int? limit = 50, int? score});

  ///Get manga details with id
  ///
  ///Throws [ServerException] for all code errors
  Future<MangaDetails> getAnimeById(int id);
}
