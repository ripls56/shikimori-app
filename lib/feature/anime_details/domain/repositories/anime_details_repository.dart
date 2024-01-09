import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_related.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_roles.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_video.dart';

///Anime details repository
abstract interface class AnimeDetailsRepository {
  ///Get anime details with id
  Future<Either<Failure, AnimeDetails>> getAnimeById(int id);

  ///Get all videos by id
  Future<Either<Failure, List<AnimeDetailsVideo>>> getVideos(int id);

  ///Get all screenshot by id
  Future<Either<Failure, List<AnimeDetailsScreenshot>>> getScreenshots(int id);

  ///Get related
  Future<Either<Failure, List<AnimeDetailsRelated>>> getRelated(int id);

  ///Get all roles by id
  Future<Either<Failure, List<AnimeDetailsRoles>>> getRoles(int id);
}
