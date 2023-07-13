import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';

///Token local repository
abstract interface class TokenLocalRepository {
  /// Add access token to flutter_secure_storage
  Future<Either<Failure, void>> saveAccessToken(String token);

  /// Add refresh token to flutter_secure_storage
  Future<Either<Failure, void>> saveRefreshToken(String token);

  ///Remove tokens from flutter_secure_storage
  Future<Either<Failure, void>> deleteTokens();
}
