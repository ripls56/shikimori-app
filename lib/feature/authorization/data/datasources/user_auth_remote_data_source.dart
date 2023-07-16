import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/authorization/domain/models/user_auth.dart';

///User auth data source
abstract interface class UserAuthRemoteDataSource {
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
