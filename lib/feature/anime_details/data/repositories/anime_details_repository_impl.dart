import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/anime_details/data/data_sources/anime_details_remote_data_source.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_related.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_roles.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_video.dart';
import 'package:shikimoriapp/feature/anime_details/domain/repositories/anime_details_repository.dart';

///Anime details repository implementation
class AnimeDetailsRepositoryImpl implements AnimeDetailsRepository {
  ///Constructor
  AnimeDetailsRepositoryImpl(this._animeDetailsRemoteDataSource);

  final AnimeDetailsRemoteDataSource _animeDetailsRemoteDataSource;

  @override
  Future<Either<Failure, AnimeDetails>> getAnimeById(int id) async {
    return _getAnimeById(
      () => _animeDetailsRemoteDataSource.getAnimeById(id),
    );
  }

  Future<Either<Failure, AnimeDetails>> _getAnimeById(
    Future<AnimeDetails> Function() anime,
  ) async {
    try {
      final model = await anime();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AnimeDetailsVideo>>> getVideos(int id) async {
    return _getVideos(
      () => _animeDetailsRemoteDataSource.getVideos(id),
    );
  }

  Future<Either<Failure, List<AnimeDetailsVideo>>> _getVideos(
    Future<List<AnimeDetailsVideo>> Function() videos,
  ) async {
    try {
      final model = await videos();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AnimeDetailsScreenshot>>> getScreenshots(
    int id,
  ) async {
    return _getScreenshots(
      () => _animeDetailsRemoteDataSource.getScreenshots(id),
    );
  }

  Future<Either<Failure, List<AnimeDetailsScreenshot>>> _getScreenshots(
    Future<List<AnimeDetailsScreenshot>> Function() screenshots,
  ) async {
    try {
      final model = await screenshots();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AnimeDetailsRoles>>> getRoles(int id) {
    return _getRoles(
      () => _animeDetailsRemoteDataSource.getRoles(id),
    );
  }

  Future<Either<Failure, List<AnimeDetailsRoles>>> _getRoles(
    Future<List<AnimeDetailsRoles>> Function() roles,
  ) async {
    try {
      final model = await roles();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AnimeDetailsRelated>>> getRelated(int id) async {
    return _getRelated(
      () => _animeDetailsRemoteDataSource.getRelated(id),
    );
  }

  Future<Either<Failure, List<AnimeDetailsRelated>>> _getRelated(
    Future<List<AnimeDetailsRelated>> Function() related,
  ) async {
    try {
      final model = await related();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
