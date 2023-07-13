import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/domain/repositories/anime_details_repository.dart';

///The use case for getting anime [AnimeDetailsScreenshot] by anime id
class GetScreenshots
    extends UseCase<List<AnimeDetailsScreenshot>, GetScreenshotsParams> {
  ///Constructor
  GetScreenshots(this._animeDetailsRepository);
  final AnimeDetailsRepository _animeDetailsRepository;

  @override
  Future<Either<Failure, List<AnimeDetailsScreenshot>>> call(
    GetScreenshotsParams params,
  ) async {
    return _animeDetailsRepository.getScreenshots(params.id);
  }
}

///Params for [GetScreenshots]
class GetScreenshotsParams extends Equatable {
  ///Constructor
  const GetScreenshotsParams({required this.id});

  ///Id of anime
  final int id;

  @override
  List<Object?> get props => [id];
}
