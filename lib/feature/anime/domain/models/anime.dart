import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime_image.dart';

class Anime extends Equatable {
  ///
  const Anime({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
    required this.kind,
    required this.score,
    required this.status,
    required this.episodes,
    required this.episodesAired,
    required this.airedOn,
    this.releasedOn,
  });

  final int id;
  final String name;
  final String? russian;
  final AnimeImage? image;
  final String? url;
  final String? kind;
  final String? score;
  final String? status;
  final int? episodes;
  final int? episodesAired;
  final DateTime? airedOn;
  final DateTime? releasedOn;

  @override
  List<Object?> get props => [];
}
