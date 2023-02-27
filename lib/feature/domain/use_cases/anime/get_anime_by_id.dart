import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimori_app/core/error/failure.dart';
import 'package:shikimori_app/core/usecase/usecase.dart';
import 'package:shikimori_app/feature/domain/entities/anime/anime.dart';
import 'package:shikimori_app/feature/domain/repositories/anime_repository.dart';

class GetAnimeById extends UseCase<Anime, GetAnimeByIdParams> {
  final AnimeRepository animeRepository;

  GetAnimeById(this.animeRepository);

  @override
  Future<Either<Failure, Anime>> call(GetAnimeByIdParams params) async {
    return await animeRepository.getAnimeById(params.id);
  }
}

class GetAnimeByIdParams extends Equatable {
  final int id;

  const GetAnimeByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}
