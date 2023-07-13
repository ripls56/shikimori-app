import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';

///User auth repository
abstract interface class UserAuthRepository {
  ///Get access token
  Future<Either<Failure, UserAuth>> getAccessToken(
    String grantType,
    String identifier,
    String secret,
    String code,
    Uri redirectUri,
  );

  Future<Either<Failure, UserAuth>> refreshAccessToken(
    String grantType,
    String identifier,
    String secret,
    String refreshToken,
  );
}
