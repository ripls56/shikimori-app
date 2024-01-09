import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_related.dart';
import 'package:shikimoriapp/feature/anime_details/domain/repositories/anime_details_repository.dart';

class GetRelatedAnimes
    extends UseCase<List<AnimeDetailsRelated>, GetRelatedParams> {
  GetRelatedAnimes(this._animeDetailsRepository);

  final AnimeDetailsRepository _animeDetailsRepository;

  @override
  Future<Either<Failure, List<AnimeDetailsRelated>>> call(
    GetRelatedParams params,
  ) async {
    return await _animeDetailsRepository.getRelated(
      params.id,
    ); //order: params.order, limit: params.limit, score: params.score
  }
}

class GetRelatedParams extends Equatable {
  const GetRelatedParams({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
