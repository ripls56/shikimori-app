import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/related/data/datasources/related_remote_data_source.dart';
import 'package:shikimoriapp/feature/related/domain/models/related.dart';
import 'package:shikimoriapp/feature/related/domain/repositories/related_repository.dart';

class RelatedRepositoryImpl implements RelatedRepository {
  RelatedRepositoryImpl(this.relatedRemoteDataSource);
  final RelatedRemoteDataSource relatedRemoteDataSource;
  @override
  Future<Either<Failure, List<Related>>> getRelated(int id) async {
    return await _getRelated(() => relatedRemoteDataSource.getRelated(id));
  }

  Future<Either<Failure, List<Related>>> _getRelated(
    Future<List<Related>> Function() related,
  ) async {
    try {
      final model = await related();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
