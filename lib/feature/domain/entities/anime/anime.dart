import 'package:equatable/equatable.dart';
import 'package:shikimori_app/features.dart';
part 'image.dart';
part 'kind.dart';
part 'status.dart';

class Anime extends Equatable {
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
  final String russian;
  final Image image;
  final String url;
  final Kind kind;
  final String score;
  final Status status;
  final int episodes;
  final int episodesAired;
  final DateTime airedOn;
  final DateTime? releasedOn;

  @override
  List<Object?> get props => [];
}
