import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_roles.dart';
import 'package:shikimoriapp/feature/anime_details/domain/repositories/anime_details_repository.dart';

///The use case for getting anime [AnimeDetailsRoles] by anime id
class GetRoles extends UseCase<List<AnimeDetailsRoles>, GetRolesParams> {
  ///Constructor
  GetRoles(this._animeDetailsRepository);

  final AnimeDetailsRepository _animeDetailsRepository;

  @override
  Future<Either<Failure, List<AnimeDetailsRoles>>> call(
    GetRolesParams params,
  ) async {
    return _animeDetailsRepository.getRoles(params.id);
  }
}

///Params for [GetRoles]
class GetRolesParams extends Equatable {
  ///Constructor
  const GetRolesParams({required this.id});

  ///Id of anime
  final int id;

  @override
  List<Object?> get props => [id];
}
