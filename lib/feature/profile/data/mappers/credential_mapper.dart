import 'package:shikimoriapp/feature/profile/data/dto/credential_dto.dart';
import 'package:shikimoriapp/feature/profile/data/mappers/credential_image_mapper.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential.dart';

///[Credential] mapper
extension CrenditionalMapper on CredentialDTO {
  ///Convert to entity
  Credential toEntity() {
    return Credential(
      id: id,
      nickname: nickname,
      avatar: avatar,
      image: image.toEntity(),
      lastOnlineAt: lastOnlineAt,
      url: url,
      sex: sex,
      website: website,
      fullYears: fullYears,
      locale: locale,
    );
  }
}
