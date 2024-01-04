import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

///Model for topic updates
class TopicUpdates extends Equatable {
  ///Constructor
  const TopicUpdates({
    required this.id,
    required this.linkedAnime,
    required this.event,
    required this.createdAt,
    required this.url,
  });

  ///Id of topic
  final int id;

  ///Linked anime
  final Anime linkedAnime;

  ///Event
  final String event;

  ///Topic created time
  final DateTime createdAt;

  ///Topic url
  final String url;

  @override
  List<Object?> get props => [
        id,
        linkedAnime,
        event,
        createdAt,
        url,
      ];
}
