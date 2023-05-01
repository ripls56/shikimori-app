import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';

abstract class UserAuthRemoteDataSource {
  ///Get access token after user authorization
  ///
  ///Throws [ServerException] for all code errors
  Future<UserAuth> getAccessToken(
    String grantType,
    String identifier,
    String secret,
    String code,
    Uri redirectUri,
  );

  ///Refresh access token when expired
  ///
  ///Throws [ServerException] for all code errors
  Future<UserAuth> refreshAccessToken(
    String grantType,
    String identifier,
    String secret,
    String refreshToken,
  );
}
