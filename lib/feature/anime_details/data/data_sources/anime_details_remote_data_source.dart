import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_video.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';

///Anime details data source
abstract interface class AnimeDetailsRemoteDataSource {
  ///Get anime details with id
  ///
  ///Throws [ServerException] for all code errors
  Future<AnimeDetails> getAnimeById(int id);

  ///Get anime videos with id
  ///
  ///Throws [ServerException] for all code errors
  Future<List<AnimeDetailsVideo>> getVideos(int id);

  ///Get anime screenshots with id
  ///
  ///Throws [ServerException] for all code errors
  Future<List<AnimeDetailsScreenshot>> getScreenshots(int id);

  ///Get related with id
  ///
  ///Throws [ServerException] for all code errors
  Future<List<Related>> getRelatedAnime(int id);
}
