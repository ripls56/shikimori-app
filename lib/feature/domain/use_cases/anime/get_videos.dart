import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/repositories/anime_repository.dart';

class GetVideos extends UseCase<List<Video>, GetVideosParams> {
  final AnimeRepository animeRepository;

  GetVideos(this.animeRepository);

  @override
  Future<Either<Failure, List<Video>>> call(GetVideosParams params) async {
    return await animeRepository.getVideos(params.id);
  }
}

class GetVideosParams extends Equatable {
  final int id;

  const GetVideosParams({required this.id});

  @override
  List<Object?> get props => [id];
}
