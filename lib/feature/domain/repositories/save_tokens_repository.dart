import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';

abstract class SaveAccessTokenRepository {
  Future<Either<Failure, void>> saveAccessToken(String token);
}

abstract class SaveRefreshTokenRepository {
  Future<Either<Failure, void>> saveRefreshToken(String token);
}
