import 'package:shikimori_app/feature/domain/entities/user_auth/user_auth.dart';

abstract class UserAuthRemoteDataSource {
  ///Get access token after user authorization
  ///
  ///Throws [ServerException] for all code errors
  Future<UserAuth> auth(
      String identifier, String secret, String code, Uri redirectUri);
}
