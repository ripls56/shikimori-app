import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_video.dart';

///Anime details repository
abstract interface class AnimeDetailsRepository {
  ///Get anime details with id
  Future<Either<Failure, AnimeDetails>> getAnimeById(int id);

  ///Get all anime videos by id
  Future<Either<Failure, List<AnimeDetailsVideo>>> getVideos(int id);

  ///Get all screenshot videos by id
  Future<Either<Failure, List<AnimeDetailsScreenshot>>> getScreenshots(int id);
}
