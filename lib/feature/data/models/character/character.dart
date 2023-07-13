import 'package:shikimoriapp/feature/domain/entities/character/character.dart';

part 'anime.dart';
part 'seyu.dart';
part 'image.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required id,
    required name,
    required russian,
    required image,
    required url,
    required super.altname,
    required japanese,
    required super.description,
    required descriptionHtml,
    required super.descriptionSource,
    required favoured,
    required threadId,
    required topicId,
    required updatedAt,
    required seyu,
    required animes,
    required mangas,
  }) : super(
            id: id,
            name: name,
            russian: russian,
            image: image,
            url: url,
            japanese: japanese,
            descriptionHtml: descriptionHtml,
            favoured: favoured,
            threadId: threadId,
            topicId: topicId,
            updatedAt: updatedAt,
            seyu: seyu,
            animes: animes,
            mangas: mangas,);

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        russian: json['russian'],
        image: ImageModel.fromJson(json['image']),
        url: json['url'],
        altname: json['altname'],
        japanese: json['japanese'],
        description: json['description'],
        descriptionHtml: json['description_html'],
        descriptionSource: json['description_source'],
        favoured: json['favoured'],
        threadId: json['thread_id'],
        topicId: json['topic_id'],
        updatedAt: DateTime.parse(json['updated_at']),
        seyu: List<Seyu>.from(json['seyu'].map(SeyuModel.fromJson)),
        animes:
            List<Anime>.from(json['animes'].map(AnimeModel.fromJson)),
        mangas: List<dynamic>.from(json['mangas'].map((x) => x)),
      );
}
