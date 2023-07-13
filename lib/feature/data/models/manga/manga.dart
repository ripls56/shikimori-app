import 'package:shikimoriapp/feature/domain/entities/manga/image.dart';
import 'package:shikimoriapp/feature/domain/entities/manga/manga.dart';

part 'image.dart';

class MangaModel extends Manga {
  const MangaModel({
    required id,
    required name,
    required russian,
    required image,
    required url,
    required kind,
    required score,
    required status,
    required volumes,
    required chapters,
    required airedOn,
    required super.releasedOn,
  }) : super(
            id: id,
            name: name,
            russian: russian,
            image: image,
            url: url,
            kind: kind,
            score: score,
            status: status,
            volumes: volumes,
            chapters: chapters,
            airedOn: airedOn,);

  factory MangaModel.fromJson(Map<String, dynamic> json) => MangaModel(
        id: json['id'],
        name: json['name'],
        russian: json['russian'],
        image: ImageModel.fromJson(json['image']),
        url: json['url'],
        kind: json['kind'],
        score: json['score'],
        status: json['status'],
        volumes: json['volumes'],
        chapters: json['chapters'],
        airedOn: DateTime.parse(json['aired_on']),
        releasedOn: json['released_on'] == null
            ? null
            : DateTime.parse(json['released_on']),
      );

  @override
  List<Object?> get props => [];
}
