part of 'character.dart';

class Manga extends Equatable {
  const Manga({
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
    required this.releasedOn,
  });

  final int id;
  final String name;
  final String russian;
  final Image image;
  final String url;
  final String kind;
  final String score;
  final String status;
  final int episodes;
  final int episodesAired;
  final dynamic airedOn;
  final dynamic releasedOn;

  @override
  List<Object?> get props => [];
}
