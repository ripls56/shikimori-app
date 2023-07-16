import 'package:json_annotation/json_annotation.dart';

part 'user_auth_dto.g.dart';

///User auth data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class UserAuthDTO {
  ///Constructor
  const UserAuthDTO({
    required this.accessToken,
    required this.tokenType,
    required this.expireIn,
    required this.scope,
    required this.createdAt,
    required this.refreshToken,
  });

  factory UserAuthDTO.fromJson(Map<String, dynamic> json) =>
      _$UserAuthDTOFromJson(json);

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
}
