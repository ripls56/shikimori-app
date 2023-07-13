import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_screenshot_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';

///[AnimeDetailsScreenshot] mapper
extension AnimeDetailsScreenshotMapper on AnimeDetailsScreenshotDTO {
  ///Convert from model to entity
  AnimeDetailsScreenshot toEntity() {
    return AnimeDetailsScreenshot(
      original: original,
      preview: preview,
    );
  }
}
