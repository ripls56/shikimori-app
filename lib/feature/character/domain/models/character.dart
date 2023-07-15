import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/character/domain/models/character_seyu.dart';
import 'package:shikimoriapp/feature/image/domain/model/image.dart';

///Character model
class Character extends Equatable {
  ///Constructor
  const Character({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
    required this.altName,
    required this.japanese,
    required this.description,
    required this.descriptionHtml,
    required this.descriptionSource,
    required this.favoured,
    required this.threadId,
    required this.topicId,
    required this.updatedAt,
    required this.seyu,
    required this.animes,
    // required this.mangas,
  });

  ///Character id
  final int? id;

  ///Character name
  final String? name;

  ///Character russian name
  final String? russian;

  ///Character image
  final Image? image;

  ///Character url
  final String? url;

  ///Character alternative name
  final dynamic altName;

  ///Character japanese name
  final String? japanese;

  ///Character description
  final dynamic description;

  ///Character description html
  final String? descriptionHtml;

  ///Character description source
  final dynamic descriptionSource;

  ///Character favoured
  final bool? favoured;

  ///Character thread id
  final int? threadId;

  ///Character topic id
  final int? topicId;

  ///Character updated at
  final DateTime? updatedAt;

  ///Character seyu
  final List<CharacterSeyu?> seyu;

  ///Character animes
  final List<Anime?> animes;

  ///Character mangas
  //final List<Manga>? mangas;

  @override
  List<Object?> get props => [
        id,
        name,
        russian,
        image,
        url,
        altName,
        japanese,
        description,
        descriptionHtml,
        descriptionSource,
        favoured,
        threadId,
        topicId,
        updatedAt,
        seyu,
        animes,
        //mangas,
      ];
}
