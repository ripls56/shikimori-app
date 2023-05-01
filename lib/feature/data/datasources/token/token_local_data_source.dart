abstract class TokenLocalDataSource {
  ///Save access token in storage
  ///
  ///Throws [SaveException] for all code errors
  Future<void> saveAccessToken(String token);

  ///Save refresh token in storage
  ///
  ///Throws [SaveException] for all code errors
  Future<void> saveRefreshToken(String token);
}
