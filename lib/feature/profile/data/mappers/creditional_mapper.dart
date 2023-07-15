import 'package:shikimoriapp/feature/profile/data/dto/creditional_dto.dart';
import 'package:shikimoriapp/feature/profile/data/mappers/creditional_image_mapper.dart';
import 'package:shikimoriapp/feature/profile/domain/models/creditional.dart';

///[Creditional] mapper
extension CrenditionalMapper on CreditionalDTO {
  ///Convert to entity
  Creditional toEntity() {
    return Creditional(
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
