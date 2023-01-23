class Auth {
  final String accessToken;
  final String tokenType;
  final int expireIn;
  final String refreshToken;
  final String scope;
  final int createdAt;
  Auth(this.accessToken, this.tokenType, this.expireIn, this.scope,
      this.createdAt, this.refreshToken);

  factory Auth.fromJson(Map<String, dynamic> data) {
    final accessToken = data['access_token'];
    final tokenType = data['token_type'];
    final expireIn = data['expires_in'];
    final refreshToken = data['refresh_token'];
    final scope = data['scope'];
    final createdAt = data['created_at'];
    return Auth(
        accessToken, tokenType, expireIn, scope, createdAt, refreshToken);
  }
}
