import 'package:shikimoriapp/feature/profile/data/dto/creditional_image_dto.dart';
import 'package:shikimoriapp/feature/profile/domain/models/creditional_image.dart';

///[CreditionalImage] mapper
extension CreditionalImageMapper on CreditionalImageDTO {
  ///Convert to entity
  CreditionalImage toEntity() {
    return CreditionalImage(
      x160: x160,
      x148: x148,
      x80: x80,
      x64: x64,
      x48: x48,
      x32: x32,
      x16: x16,
    );
  }
}
