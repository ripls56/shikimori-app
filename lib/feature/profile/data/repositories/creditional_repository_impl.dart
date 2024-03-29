import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/profile/data/datasources/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/profile/domain/models/creditional.dart';
import 'package:shikimoriapp/feature/profile/domain/repositories/creditional_repository.dart';

///Creditional repository implementation
class CreditionalRepositoryImpl implements CreditionalRepository {
  ///Need datasource to work
  CreditionalRepositoryImpl(this._creditional);

  final CreditionalRemoteDataSource _creditional;

  @override
  Future<Either<Failure, Creditional>> getCreditionals(String token) async {
    return _getCreditionals(() => _creditional.getCreditionals(token));
  }

  Future<Either<Failure, Creditional>> _getCreditionals(
    Future<Creditional> Function() creditional,
  ) async {
    try {
      final model = await creditional();
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        if (e.error == 'invalid_grant') {
          return const Left(AuthFailure());
        }
      }
      return const Left(ServerFailure());
    }
  }
}
