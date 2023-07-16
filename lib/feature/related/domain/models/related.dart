import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

///Related model
class Related extends Equatable {
  ///Constructor
  const Related({
    this.relation,
    this.relationRussian,
    this.anime,
    //this.manga,
  });

  ///Relation
  final String? relation;

  ///Relation russian
  final String? relationRussian;

  ///Anime
  final Anime? anime;

  //final Manga? manga;

  @override
  List<Object?> get props => [];
}
