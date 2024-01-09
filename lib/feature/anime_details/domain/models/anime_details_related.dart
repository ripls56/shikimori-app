import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

///Related model
class AnimeDetailsRelated extends Equatable {
  ///Constructor
  const AnimeDetailsRelated({
    this.relation,
    this.relationRussian,
    this.anime,
  });

  ///Relation
  final String? relation;

  ///Relation russian
  final String? relationRussian;

  ///Anime
  final Anime? anime;

  @override
  List<Object?> get props => [];
}
