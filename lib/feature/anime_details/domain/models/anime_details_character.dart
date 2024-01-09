import 'package:shikimoriapp/feature/image/domain/model/image.dart';

///Anime character model
class AnimeDetailsCharacter {
  ///Constructor
  AnimeDetailsCharacter({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
  });

  ///Character id
  final int id;

  ///Character name
  final String name;

  ///Character russian name
  final String russian;

  ///Character image
  final Image image;

  ///Character url
  final String url;
}
