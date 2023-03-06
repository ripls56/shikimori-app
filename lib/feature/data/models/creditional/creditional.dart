import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';

part 'image.dart';

class CreditionalModel extends Creditional {
  const CreditionalModel({
    required id,
    required nickname,
    required avatar,
    required image,
    required lastOnlineAt,
    required url,
    name,
    required sex,
    required website,
    birthOn,
    required fullYears,
    required locale,
  }) : super(
            id: id,
            nickname: nickname,
            avatar: avatar,
            image: image,
            lastOnlineAt: lastOnlineAt,
            url: url,
            sex: sex,
            website: website,
            fullYears: fullYears,
            locale: locale);

  factory CreditionalModel.fromJson(Map<String, dynamic> json) =>
      CreditionalModel(
        id: json["id"],
        nickname: json["nickname"],
        avatar: json["avatar"],
        image: ImageModel.fromJson(json["image"]),
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
        "image": image, // or ImageModel.toJson() пока хз
        "last_online_at": lastOnlineAt.toIso8601String(),
        "url": url,
        "name": name,
        "sex": sex,
        "website": website,
        "birth_on": birthOn,
        "full_years": fullYears,
        "locale": locale,
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}
