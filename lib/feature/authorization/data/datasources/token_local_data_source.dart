import 'package:shikimoriapp/core/error/exception.dart';

///Token local data source
abstract interface class TokenLocalDataSource {
  ///Save access token in storage
  ///
  ///Throws [SaveException] for all code errors
  Future<void> saveAccessToken(String token);

  ///Save refresh token in storage
  ///
  ///Throws [SaveException] for all code errors
  Future<void> saveRefreshToken(String token);

  ///Get access token from storage
  ///
  /// Throws [GetTokenException] for all code errors
  Future<String> getAccessToken();

  ///Get refresh token from storage
  ///
  /// Throws [GetTokenException] for all code errors
  Future<String> getRefreshToken();

  ///Delete tokens from storage
  ///
  ///Throws [DeleteException] for all code errors
  Future<void> deleteTokens();
}
