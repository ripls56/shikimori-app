import 'package:equatable/equatable.dart';

part 'genre.dart';
part 'image.dart';
part 'rates_score_stat.dart';
part 'rates_statuses_stat.dart';
part 'screenshot.dart';
part 'studio.dart';
part 'video.dart';

class AnimeDetails extends Equatable {
  const AnimeDetails({
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
    required this.rating,
    required this.english,
    required this.japanese,
    required this.synonyms,
    this.licenseNameRu,
    required this.duration,
    required this.description,
    required this.descriptionHtml,
    this.descriptionSource,
    required this.franchise,
    required this.favoured,
    required this.anons,
    required this.ongoing,
    required this.threadId,
    required this.topicId,
    required this.myanimelistId,
    required this.ratesScoresStats,
    required this.ratesStatusesStats,
    required this.updatedAt,
    this.nextEpisodeAt,
    required this.fansubbers,
    required this.fandubbers,
    required this.licensors,
    required this.genres,
    required this.studios,
    required this.videos,
    required this.screenshots,
    this.userRate,
  });

  final int? id;
  final String? name;
  final String? russian;
  final Image? image;
  final String? url;
  final String? kind;
  final String? score;
  final String? status;
  final int? episodes;
  final int? episodesAired;
  final DateTime? airedOn;
  final DateTime? releasedOn;
  final String? rating;
  final List<String?> english;
  final List<String?> japanese;
  final List<String?> synonyms;
  final dynamic licenseNameRu;
  final int? duration;
  final String? description;
  final String? descriptionHtml;
  final dynamic descriptionSource;
  final String? franchise;
  final bool? favoured;
  final bool? anons;
  final bool? ongoing;
  final int? threadId;
  final int? topicId;
  final int? myanimelistId;
  final List<RatesScoresStat?> ratesScoresStats;
  final List<RatesStatusesStat?> ratesStatusesStats;
  final DateTime? updatedAt;
  final dynamic nextEpisodeAt;
  final List<String?> fansubbers;
  final List<String?> fandubbers;
  final List<dynamic> licensors;
  final List<Genre?> genres;
  final List<Studio?> studios;
  final List<Video?> videos;
  final List<Screenshot?> screenshots;
  final dynamic userRate;

  @override
  List<Object?> get props => throw UnimplementedError();
}
