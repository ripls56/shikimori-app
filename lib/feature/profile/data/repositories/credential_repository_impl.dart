import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/profile/data/datasources/credential_remote_data_source.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential.dart';
import 'package:shikimoriapp/feature/profile/domain/repositories/credential_repository.dart';

///Credential repository implementation
class CredentialRepositoryImpl implements CredentialRepository {
  ///Need datasource to work
  CredentialRepositoryImpl(this._credentialDataSource);

  final CredentialRemoteDataSource _credentialDataSource;

  @override
  Future<Either<Failure, Credential>> getCredentials(String token) async {
    return _getCredentials(() => _credentialDataSource.getCredentials(token));
  }

  Future<Either<Failure, Credential>> _getCredentials(
    Future<Credential> Function() credential,
  ) async {
    try {
      final model = await credential();
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
