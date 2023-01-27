part 'image.dart';

class Creditional {
  Creditional({
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

  factory Creditional.fromJson(Map<String, dynamic> json) => Creditional(
        id: json["id"],
        nickname: json["nickname"],
        avatar: json["avatar"],
        image: Image.fromJson(json["image"]),
        lastOnlineAt: DateTime.parse(json["last_online_at"]),
        url: json["url"],
        name: json["name"],
        sex: json["sex"],
        website: json["website"],
        birthOn: json["birth_on"],
        fullYears: json["full_years"],
        locale: json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "avatar": avatar,
        "image": image.toJson(),
        "last_online_at": lastOnlineAt.toIso8601String(),
        "url": url,
        "name": name,
        "sex": sex,
        "website": website,
        "birth_on": birthOn,
        "full_years": fullYears,
        "locale": locale,
      };
}
