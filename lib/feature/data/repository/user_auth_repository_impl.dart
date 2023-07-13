import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/repositories/user_auth_repository.dart';

///User auth repository implementation
class UserAuthRepositoryImpl implements UserAuthRepository {
  ///Need data source to work
  UserAuthRepositoryImpl(this._tokenRemoteDataSource);

  final UserAuthRemoteDataSource _tokenRemoteDataSource;

  @override
  Future<Either<Failure, UserAuth>> refreshAccessToken(
    String grantType,
    String identifier,
    String secret,
    String refreshToken,
  ) async {
    return _refreshAccessToken(
      () => _tokenRemoteDataSource.refreshAccessToken(
        grantType,
        identifier,
        secret,
        refreshToken,
      ),
    );
  }

  Future<Either<Failure, UserAuth>> _refreshAccessToken(
    Future<UserAuth> Function() auth,
  ) async {
    try {
      final model = await auth();
      return Right(model);
    } on DioException {
      return Left(AuthFailure());
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserAuth>> getAccessToken(
    String grantType,
    String identifier,
    String secret,
    String code,
    Uri redirectUri,
  ) async {
    return _getAccessToken(
      () => _tokenRemoteDataSource.getAccessToken(
        grantType,
        identifier,
        secret,
        code,
        redirectUri,
      ),
    );
  }

  Future<Either<Failure, UserAuth>> _getAccessToken(
    Future<UserAuth> Function() auth,
  ) async {
    try {
      final model = await auth();
      return Right(model);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
