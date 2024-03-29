import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/related/domain/models/related.dart';
import 'package:shikimoriapp/feature/related/domain/repositories/related_repository.dart';

class GetRelatedAnimes extends UseCase<List<Related>, GetRelatedParams> {
  GetRelatedAnimes(this.relatedRepository);
  final RelatedRepository relatedRepository;

  @override
  Future<Either<Failure, List<Related>>> call(GetRelatedParams params) async {
    return await relatedRepository.getRelated(
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
