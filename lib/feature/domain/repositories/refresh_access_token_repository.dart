import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';

abstract class RefreshAccessTokenRepository {
  Future<Either<Failure, UserAuth>> refreshAccessToken(
    String grantType,
    String identifier,
    String secret,
    String refreshToken,
  );
}
