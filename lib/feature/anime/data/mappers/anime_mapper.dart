import 'package:shikimoriapp/feature/anime/data/dto/anime_dto.dart';
import 'package:shikimoriapp/feature/anime/data/mappers/anime_image_mapper.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

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
