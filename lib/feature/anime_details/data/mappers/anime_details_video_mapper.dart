import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_video_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_video.dart';

///[AnimeDetailsVideo] mapper
extension AnimeDetailsVideoMapper on AnimeDetailsVideoDTO {
  ///Convert from model to entity
  AnimeDetailsVideo toEntity() {
    return AnimeDetailsVideo(
      id: id,
      url: url,
      playerUrl: playerUrl,
      name: name,
      kind: kind,
      hosting: hosting,
      imageUrl: imageUrl,
    );
  }
}
