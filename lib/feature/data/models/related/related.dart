import 'package:shikimoriapp/feature/data/models/manga/manga.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';
import '../anime/anime.dart';

class RelatedModel extends Related {
  const RelatedModel({
    required relation,
    required relationRussian,
    required anime,
    required manga,
  }) : super(
            relation: relation,
            relationRussian: relationRussian,
            anime: anime,
            manga: manga);

  factory RelatedModel.fromJson(Map<String, dynamic> json) => RelatedModel(
        relation: json["relation"],
        relationRussian: json["relation_russian"],
        anime:
            json["anime"] == null ? null : AnimeModel.fromJson(json["anime"]),
        manga:
            json["manga"] == null ? null : MangaModel.fromJson(json["manga"]),
      );
}
