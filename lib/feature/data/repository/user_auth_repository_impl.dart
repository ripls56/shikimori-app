import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/feature/domain/repositories/access_token_repository.dart';

class GetAccessTokenRepositoryImpl implements GetAccessTokenRepository {
  final UserAuthRemoteDataSource tokenRemoteDataSource;

  GetAccessTokenRepositoryImpl(this.tokenRemoteDataSource);
  @override
  Future<Either<Failure, UserAuth>> getAccessToken(String grantType,
      String identifier, String secret, String code, Uri redirectUri) async {
    return await _auth(() => tokenRemoteDataSource.getAccessToken(
        grantType, identifier, secret, code, redirectUri));
  }

  Future<Either<Failure, UserAuth>> _auth(
      Future<UserAuth> Function() auth) async {
    try {
      final model = await auth();
      return Right(model);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
