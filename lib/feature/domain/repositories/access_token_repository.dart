import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';

abstract class GetAccessTokenRepository {
  Future<Either<Failure, UserAuth>> getAccessToken(String grantType,
      String identifier, String secret, String code, Uri redirectUri);
}
