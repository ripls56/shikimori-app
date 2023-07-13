import 'package:equatable/equatable.dart';

///Video model
class AnimeDetailsVideo extends Equatable {
  ///Constructor
  const AnimeDetailsVideo({
    required this.id,
    required this.url,
    required this.imageUrl,
    required this.playerUrl,
    required this.name,
    required this.kind,
    required this.hosting,
  });

  ///Video id
  final int id;

  ///Video url
  final String url;

  ///Video image url
  final String imageUrl;

  ///Video player url
  final String playerUrl;

  ///Video name
  final String name;

  ///Video kind
  final String kind;

  ///Video hosting
  final String hosting;

  @override
  List<Object?> get props => [];
}
