import 'package:dio/dio.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/feature/domain/repositories/creditional_repository.dart';

class CreditionalRepositoryImpl implements CreditionalRepository {
  final CreditionalRemoteDataSource creditional;

  CreditionalRepositoryImpl(this.creditional);
  @override
  Future<Either<Failure, Creditional>> getCreditionals(String token) async {
    return await _getCreditionals(() => creditional.getCreditionals(token));
  }

  Future<Either<Failure, Creditional>> _getCreditionals(
      Future<Creditional> Function() creditional) async {
    try {
      final model = await creditional();
      return Right(model);
    } catch (e) {
      if (e is DioError) {
        if (e.error == "invalid_grant") {
          return Left(AuthFailure());
        }
      }
      return Left(ServerFailure());
    }
  }
}
