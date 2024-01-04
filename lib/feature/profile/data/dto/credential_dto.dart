import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/profile/data/dto/credential_image_dto.dart';

part 'credential_dto.g.dart';

///Credential data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class CredentialDTO {
  ///Constructor
  const CredentialDTO({
    required this.id,
    required this.nickname,
    required this.avatar,
    required this.image,
    required this.lastOnlineAt,
    required this.url,
    required this.sex,
    required this.website,
    required this.fullYears,
    required this.locale,
    this.name,
    this.birthOn,
  });

  factory CredentialDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialDTOFromJson(json);

  ///User id
  final int id;

  ///User nickname
  final String nickname;

  ///User avatar
  final String avatar;

  ///User image
  final CredentialImageDTO image;

  ///User last online at
  final DateTime lastOnlineAt;

  ///User url
  final String url;

  ///User name
  final dynamic name;

  ///User sex
  final String sex;

  ///User website
  final String website;

  ///User birth on
  final dynamic birthOn;

  ///User full years
  final int fullYears;

  ///User locale
  final String locale;
}
