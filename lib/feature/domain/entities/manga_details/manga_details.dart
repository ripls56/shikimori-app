import 'package:equatable/equatable.dart';

part 'genre.dart';
part 'image.dart';
part 'publisher.dart';
part 'rates_scores_stat.dart';
part 'rates_statuses_stat.dart';

class MangaDetails extends Equatable {
  const MangaDetails({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
    required this.kind,
    required this.score,
    required this.status,
    required this.volumes,
    required this.chapters,
    required this.airedOn,
    required this.releasedOn,
    required this.english,
    required this.japanese,
    required this.synonyms,
    required this.licenseNameRu,
    required this.description,
    required this.descriptionHtml,
    required this.descriptionSource,
    required this.franchise,
    required this.favoured,
    required this.anons,
    required this.ongoing,
    required this.threadId,
    required this.topicId,
    required this.myanimelistId,
    required this.ratesScoresStats,
    required this.ratesStatusesStats,
    required this.licensors,
    required this.genres,
    required this.publishers,
    required this.userRate,
  });

  final int? id;
  final String? name;
  final String? russian;
  final Image? image;
  final String? url;
  final String? kind;
  final String? score;
  final String? status;
  final int? volumes;
  final int? chapters;
  final DateTime? airedOn;
  final DateTime? releasedOn;
  final List<String>? english;
  final List<String>? japanese;
  final List<dynamic>? synonyms;
  final String? licenseNameRu;
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
  final List<RatesScoresStat>? ratesScoresStats;
  final List<RatesStatusesStat>? ratesStatusesStats;
  final List<String>? licensors;
  final List<Genre>? genres;
  final List<Publisher>? publishers;
  final dynamic userRate;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
