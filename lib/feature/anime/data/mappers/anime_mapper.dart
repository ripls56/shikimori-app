import 'package:shikimoriapp/feature/anime/data/dto/anime_dto.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/image/data/mapper/image_mapper.dart';

///Mapper for [AnimeDTO]
extension AnimeMapper on AnimeDTO {
  ///Converts to [Anime]
  Anime toEntity() {
    return Anime(
      id: id,
      name: name,
      russian: russian,
      image: image?.toEntity(),
      url: url,
      kind: kind,
      score: score,
      status: status,
      episodes: episodes,
      episodesAired: episodesAired,
      airedOn: airedOn,
      releasedOn: releasedOn,
    );
  }
}
