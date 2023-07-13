import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime/domain/repositories/anime_repository.dart';

///The [GetAnimeByName] class is a use case, which is used
///to get a list of [Anime] by their names.
class GetAnimeByName extends UseCase<List<Anime>, GetAnimesByNameParams> {
  /// GetAnimeByName constructor
  GetAnimeByName(this._animeRepository);
  final AnimeRepository _animeRepository;

  @override
  Future<Either<Failure, List<Anime>>> call(
      GetAnimesByNameParams params,) async {
    return _animeRepository.getAnimesByName(
      params.phrase,
      limit: params.limit,
    );
  }
}

///Params for the [GetAnimeByName] use case.
class GetAnimesByNameParams extends Equatable {
  ///Constructor for the [GetAnimesByNameParams] class.
  const GetAnimesByNameParams({
    required this.phrase,
    this.limit,
  });

  /// The [phrase] is the phrase of the list of [Anime].
  final String phrase;

  /// The [limit] is the limit of the list of [Anime].
  final int? limit;

  @override
  List<Object?> get props => [phrase, limit];
}
