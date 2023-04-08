import 'package:equatable/equatable.dart';

part 'anime.dart';
part 'seyu.dart';
part 'image.dart';
part 'manga.dart';

class Character extends Equatable {
  const Character({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
    required this.altname,
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
    required this.mangas,
  });

  final int id;
  final String name;
  final String russian;
  final Image image;
  final String url;
  final dynamic altname;
  final String japanese;
  final dynamic description;
  final String descriptionHtml;
  final dynamic descriptionSource;
  final bool favoured;
  final int threadId;
  final int topicId;
  final DateTime updatedAt;
  final List<Seyu> seyu;
  final List<Anime> animes;
  final List<dynamic> mangas;

  @override
  List<Object?> get props => [];
}
