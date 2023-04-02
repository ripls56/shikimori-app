import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/repositories/anime_repository.dart';

class GetAnimeById extends UseCase<AnimeDetails, GetAnimeByIdParams> {
  final AnimeRepository animeRepository;

  GetAnimeById(this.animeRepository);

  @override
  Future<Either<Failure, AnimeDetails>> call(GetAnimeByIdParams params) async {
    return await animeRepository.getAnimeById(params.id);
  }
}

class GetAnimeByIdParams extends Equatable {
  final int id;

  const GetAnimeByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}
