import 'package:equatable/equatable.dart';

class UserAuth extends Equatable {
  const UserAuth(
      {required this.accessToken,
      required this.tokenType,
      required this.expireIn,
      required this.scope,
      required this.createdAt,
      required this.refreshToken,});
  final String? accessToken;
  final String? tokenType;
  final int? expireIn;
  final String? refreshToken;
  final String? scope;
  final int? createdAt;

  @override
  List<Object?> get props => [];
}
