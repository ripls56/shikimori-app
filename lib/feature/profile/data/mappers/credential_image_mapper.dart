import 'package:shikimoriapp/feature/profile/data/dto/credential_image_dto.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential_image.dart';

///[CredentialImage] mapper
extension CredentialImageMapper on CredentialImageDTO {
  ///Convert to entity
  CredentialImage toEntity() {
    return CredentialImage(
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
