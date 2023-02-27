part of 'anime_details.dart';

class Video extends Equatable {
  const Video({
    required this.id,
    required this.url,
    required this.imageUrl,
    required this.playerUrl,
    required this.name,
    required this.kind,
    required this.hosting,
  });

  final int id;
  final String url;
  final String imageUrl;
  final String playerUrl;
  final String name;
  final String kind;
  final String hosting;

  @override
  List<Object?> get props => [];
}
