import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/feature/domain/repositories/refresh_access_token_repository.dart';

class RefreshAccessTokenRepositoryImpl implements RefreshAccessTokenRepository {
  final UserAuthRemoteDataSource tokenRemoteDataSource;

  RefreshAccessTokenRepositoryImpl(this.tokenRemoteDataSource);
  @override
  Future<Either<Failure, UserAuth>> refreshAccessToken(
    String grantType,
    String identifier,
    String secret,
    String refreshToken,
  ) async {
    return await _auth(() => tokenRemoteDataSource.refreshAccessToken(
        grantType, identifier, secret, refreshToken));
  }

  Future<Either<Failure, UserAuth>> _auth(
      Future<UserAuth> Function() auth) async {
    try {
      final model = await auth();
      return Right(model);
    } on DioError {
      return Left(AuthFailure());
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
