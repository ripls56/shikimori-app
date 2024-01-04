import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential.dart';

///User credential repository
abstract interface class CredentialRepository {
  ///Get user credentials with access token
  Future<Either<Failure, Credential>> getCredentials(String token);
}
