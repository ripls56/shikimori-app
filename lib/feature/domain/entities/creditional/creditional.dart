import 'package:equatable/equatable.dart';

part 'image.dart';

class Creditional extends Equatable {
  const Creditional({
    required this.id,
    required this.nickname,
    required this.avatar,
    required this.image,
    required this.lastOnlineAt,
    required this.url,
    this.name,
    required this.sex,
    required this.website,
    this.birthOn,
    required this.fullYears,
    required this.locale,
  });

  final int id;
  final String nickname;
  final String avatar;
  final Image image;
  final DateTime lastOnlineAt;
  final String url;
  final dynamic name;
  final String sex;
  final String website;
  final dynamic birthOn;
  final int fullYears;
  final String locale;

  @override
  List<Object?> get props => [];
}
