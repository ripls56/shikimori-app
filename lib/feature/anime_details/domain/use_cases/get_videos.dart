import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_video.dart';
import 'package:shikimoriapp/feature/anime_details/domain/repositories/anime_details_repository.dart';

///The use case for getting anime [AnimeDetailsVideo] by anime id
class GetVideos extends UseCase<List<AnimeDetailsVideo>, GetVideosParams> {
  ///Constructor
  GetVideos(this._animeDetailsRepository);
  final AnimeDetailsRepository _animeDetailsRepository;

  @override
  Future<Either<Failure, List<AnimeDetailsVideo>>> call(
      GetVideosParams params) async {
    return _animeDetailsRepository.getVideos(params.id);
  }
}

///Params for [GetVideos]
class GetVideosParams extends Equatable {
  ///Constructor
  const GetVideosParams({required this.id});

  ///Id of anime
  final int id;

  @override
  List<Object?> get props => [id];
}
