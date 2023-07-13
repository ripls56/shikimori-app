import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

import '../manga/manga.dart';

class Related extends Equatable {
  const Related({
    this.relation,
    this.relationRussian,
    this.anime,
    this.manga,
  });

  final String? relation;
  final String? relationRussian;
  final Anime? anime;
  final Manga? manga;

  @override
  List<Object?> get props => [];
}
