import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/repositories/anime_repository.dart';

class GetAnimes extends UseCase<List<Anime>, GetAnimesParams> {
  final AnimeRepository animeRepository;

  GetAnimes(this.animeRepository);

  @override
  Future<Either<Failure, List<Anime>>> call(GetAnimesParams params) async {
    return await animeRepository.getAnimes(params
        .page); //order: params.order, limit: params.limit, score: params.score
  }
}

class GetAnimesParams extends Equatable {
  final int page;
  final String? order;
  final int? limit;
  final int? score;

  const GetAnimesParams({
    this.order,
    this.limit,
    this.score,
    required this.page,
  });

  @override
  List<Object?> get props => [page, order, limit, score];
}
