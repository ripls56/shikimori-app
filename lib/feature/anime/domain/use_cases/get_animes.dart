import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime/domain/repositories/anime_repository.dart';

/// The [GetAnimes] class is a use case, which is used to get a list of [Anime].
class GetAnimes extends UseCase<List<Anime>, GetAnimesParams> {
  /// The [AnimeRepository] is injected into the [GetAnimes] class.
  GetAnimes(this._animeRepository);

  final AnimeRepository _animeRepository;

  @override
  Future<Either<Failure, List<Anime>>> call(GetAnimesParams params) async {
    return _animeRepository.getAnimes(
      params.page,
      order: params.order,
    ); //order: params.order, limit: params.limit, score: params.score
  }
}

///Params for the [GetAnimes] use case.
class GetAnimesParams extends Equatable {
  ///Constructor for the [GetAnimesParams] class.
  const GetAnimesParams({
    required this.page,
    this.order,
    this.limit,
    this.score,
  });

  /// The [page] is the page number of the list of [Anime].
  final int page;

  /// The [order] is the order of the list of [Anime].
  final String? order;

  /// The [limit] is the limit of the list of [Anime].
  final int? limit;

  /// The [score] is the score of the list of [Anime].
  final int? score;

  @override
  List<Object?> get props => [page, order, limit, score];
}
