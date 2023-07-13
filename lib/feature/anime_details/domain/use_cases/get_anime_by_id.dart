import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/repositories/anime_details_repository.dart';

///The use case for getting [AnimeDetails] by id
class GetAnimeById extends UseCase<AnimeDetails, GetAnimeByIdParams> {
  ///Constructor
  GetAnimeById(this._animeDetailsRepository);
  final AnimeDetailsRepository _animeDetailsRepository;

  @override
  Future<Either<Failure, AnimeDetails>> call(GetAnimeByIdParams params) async {
    return _animeDetailsRepository.getAnimeById(params.id);
  }
}

///Params for [GetAnimeById]
class GetAnimeByIdParams extends Equatable {
  ///Constructor
  const GetAnimeByIdParams({required this.id});

  ///Id of anime
  final int id;

  @override
  List<Object?> get props => [id];
}
