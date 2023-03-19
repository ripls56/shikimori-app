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

  ///Get all anime videos by id
  Future<Either<Failure, List<Video>>> getVideos(int id);

  ///Get all screenshot videos by id
  Future<Either<Failure, List<Screenshot>>> getScreenshots(int id);
}
