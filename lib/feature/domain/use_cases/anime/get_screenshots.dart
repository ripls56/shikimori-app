import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/repositories/anime_repository.dart';

class GetScreenshots extends UseCase<List<Screenshot>, GetScreenshotsParams> {
  final AnimeRepository animeRepository;

  GetScreenshots(this.animeRepository);

  @override
  Future<Either<Failure, List<Screenshot>>> call(
      GetScreenshotsParams params) async {
    return await animeRepository.getScreenshots(params.id);
  }
}

class GetScreenshotsParams extends Equatable {
  final int id;

  const GetScreenshotsParams({required this.id});

  @override
  List<Object?> get props => [id];
}
