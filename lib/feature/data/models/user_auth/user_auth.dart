import 'package:shikimori_app/feature/domain/entities/user_auth/user_auth.dart';

class UserAuthModel extends UserAuth {
  const UserAuthModel({
    required accessToken,
    required tokenType,
    required expireIn,
    required scope,
    required createdAt,
    required refreshToken,
  }) : super(
            accessToken: accessToken,
            tokenType: tokenType,
            expireIn: expireIn,
            scope: scope,
            createdAt: createdAt,
            refreshToken: refreshToken);

  factory UserAuthModel.fromJson(Map<String, dynamic> data) => UserAuthModel(
      accessToken: data['access_token'],
      tokenType: data['token_type'],
      expireIn: data['expires_in'],
      scope: data['scope'],
      createdAt: data['created_at'],
      refreshToken: data['refresh_token']);

  @override
  List<Object?> get props => [];
}
