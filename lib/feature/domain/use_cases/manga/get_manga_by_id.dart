import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/anime/data/datasources/repositories/anime_repository.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';

class GetAnimeById extends UseCase<AnimeDetails, GetAnimeByIdParams> {

  GetAnimeById(this.animeRepository);
  final AnimeRepository animeRepository;

  @override
  Future<Either<Failure, AnimeDetails>> call(GetAnimeByIdParams params) async {
    return await animeRepository.getAnimeById(params.id);
  }
}

class GetAnimeByIdParams extends Equatable {

  const GetAnimeByIdParams({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}
