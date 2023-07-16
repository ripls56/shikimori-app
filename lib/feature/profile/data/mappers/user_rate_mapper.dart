import 'package:shikimoriapp/feature/profile/data/dto/user_rate_dto.dart';
import 'package:shikimoriapp/feature/profile/domain/models/user_rate.dart';

///[UserRate] mapper
extension UserRateMapper on UserRateDTO {
  ///Convert [UserRateDTO] to [UserRate]
  UserRate toEntity() => UserRate(
        id: id,
        userId: userId,
        targetId: targetId,
        targetType: targetType,
        score: score,
        status: status,
        rewatches: rewatches,
        episodes: episodes,
        volumes: volumes,
        chapters: chapters,
        text: text,
        textHtml: textHtml,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
