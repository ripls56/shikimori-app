import 'package:equatable/equatable.dart';

///User auth model
class UserAuth extends Equatable {
  ///Constructor
  const UserAuth({
    required this.accessToken,
    required this.tokenType,
    required this.expireIn,
    required this.scope,
    required this.createdAt,
    required this.refreshToken,
  });

  ///Access token
  final String? accessToken;

  ///Token type
  final String? tokenType;

  ///Expire in
  final int? expireIn;

  ///Refresh token
  final String? refreshToken;

  ///Scope
  final String? scope;

  ///Created at
  final int? createdAt;

  @override
  List<Object?> get props =>
      [accessToken, tokenType, expireIn, refreshToken, scope, createdAt];
}
