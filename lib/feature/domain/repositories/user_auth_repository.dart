import 'package:dartz/dartz.dart';
import 'package:shikimori_app/core/error/failure.dart';
import 'package:shikimori_app/feature/domain/entities/user_auth/user_auth.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, UserAuth>> auth(
      String identifier, String secret, String code, Uri redirectUri);
}
