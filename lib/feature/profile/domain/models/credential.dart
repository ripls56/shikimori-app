import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential_image.dart';

///Credential model
class Credential extends Equatable {
  ///Constructor
  const Credential({
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

  ///User id
  final int id;

  ///User nickname
  final String nickname;

  ///User avatar
  final String avatar;

  ///User image
  final CredentialImage image;

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

  @override
  List<Object?> get props => [];
}
