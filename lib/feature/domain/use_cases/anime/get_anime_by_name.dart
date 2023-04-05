import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/repositories/anime_repository.dart';

class GetAnimeByName extends UseCase<List<Anime>, GetAnimesByNameParams> {
  final AnimeRepository animeRepository;

  GetAnimeByName(this.animeRepository);

  @override
  Future<Either<Failure, List<Anime>>> call(
      GetAnimesByNameParams params) async {
    return await animeRepository.getAnimesByName(
      params.phrase,
      limit: params.limit,
    );
  }
}

class GetAnimesByNameParams extends Equatable {
  final String phrase;

  final int? limit;

  const GetAnimesByNameParams({
    this.limit,
    required this.phrase,
  });

  @override
  List<Object?> get props => [phrase, limit];
}
