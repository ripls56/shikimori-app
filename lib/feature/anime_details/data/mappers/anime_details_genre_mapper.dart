import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_genre_dto.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_genre.dart';

///[AnimeDetailsGenre] mapper
extension AnimeDetailsGenreMapper on AnimeDetailsGenreDTO {
  ///Convert from model to entity
  AnimeDetailsGenre toEntity() {
    return AnimeDetailsGenre(
      id: id,
      name: name,
      russian: russian,
      kind: kind,
    );
  }
}
