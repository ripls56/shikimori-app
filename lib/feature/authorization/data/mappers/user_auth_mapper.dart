import 'package:shikimoriapp/feature/authorization/data/dto/user_auth_dto.dart';
import 'package:shikimoriapp/feature/authorization/domain/models/user_auth.dart';

///[UserAuth] mapper
extension UserAuthMapper on UserAuthDTO {
  ///Convert [UserAuthDTO] to [UserAuth]
  UserAuth toEntity() => UserAuth(
        accessToken: accessToken,
        tokenType: tokenType,
        expireIn: expireIn,
        scope: scope,
        createdAt: createdAt,
        refreshToken: refreshToken,
      );
}
