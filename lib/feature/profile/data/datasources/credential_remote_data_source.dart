import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential.dart';

///User credential remote data source
abstract interface class CredentialRemoteDataSource {
  ///Get user credentials
  ///
  ///Throws [ServerException] for all code errors
  Future<Credential> getCredentials(String token);
}
