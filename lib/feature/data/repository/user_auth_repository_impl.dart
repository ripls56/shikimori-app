import 'package:shikimori_app/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimori_app/feature/data/datasources/user_auth/user_auth_remote_data_source_impl.dart';
import 'package:shikimori_app/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimori_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shikimori_app/feature/domain/repositories/user_auth_repository.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  UserAuthRemoteDataSource userAuthlRemoteDataSource =
      UserAuthRemoteDataSourceImpl();
  @override
  Future<Either<Failure, UserAuth>> auth(
      String identifier, String secret, String code, Uri redirectUri) async {
    return await _auth(() =>
        userAuthlRemoteDataSource.auth(identifier, secret, code, redirectUri));
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
