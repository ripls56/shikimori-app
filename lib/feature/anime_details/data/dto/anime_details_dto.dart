import 'package:json_annotation/json_annotation.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_genre_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_rates_score_stat_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_rates_statuses_stat_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_screenshot_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_studio_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_video_dto.dart';
import 'package:shikimoriapp/feature/image/data/dto/image_dto.dart';

part 'anime_details_dto.g.dart';

///Anime details data transfer object
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeDetailsDTO {
  ///Constructor
  const AnimeDetailsDTO({
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
    required this.duration,
    required this.description,
    required this.descriptionHtml,
    required this.franchise,
    required this.favoured,
    required this.anons,
    required this.ongoing,
    required this.threadId,
    required this.topicId,
    required this.myAnimeListId,
    required this.ratesScoresStats,
    required this.ratesStatusesStats,
    required this.updatedAt,
    required this.fanSubbers,
    required this.fanDubbers,
    required this.licensors,
    required this.genres,
    required this.studios,
    required this.videos,
    required this.screenshots,
    this.licenseNameRu,
    this.descriptionSource,
    this.nextEpisodeAt,
    this.userRate,
  });

  factory AnimeDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailsDTOFromJson(json);

  ///Anime id
  final int? id;

  ///Anime name
  final String? name;

  ///Anime russian name
  final String? russian;

  ///Anime image
  final ImageDTO? image;

  ///Anime url
  final String? url;

  ///Anime kind
  final String? kind;

  ///Anime score
  final String? score;

  ///Anime status
  final String? status;

  ///Anime episodes
  final int? episodes;

  ///Anime episodes aired
  final int? episodesAired;

  ///Anime aired on
  final DateTime? airedOn;

  ///Anime released on
  final DateTime? releasedOn;

  ///Anime rating
  final String? rating;

  ///Anime english
  final List<String?> english;

  ///Anime japanese
  final List<String?> japanese;

  ///Anime synonyms
  final List<String?> synonyms;

  ///Anime license name ru
  final dynamic licenseNameRu;

  ///Anime duration
  final int? duration;

  ///Anime description
  final String? description;

  ///Anime description html
  final String? descriptionHtml;

  ///Anime description source
  final dynamic descriptionSource;

  ///Anime franchise
  final String? franchise;

  ///Anime favoured
  final bool? favoured;

  ///Anime anons
  final bool? anons;

  ///Anime ongoing
  final bool? ongoing;

  ///Anime thread id
  final int? threadId;

  ///Anime topic id
  final int? topicId;

  ///Anime my anime list id
  final int? myAnimeListId;

  ///Anime rates scores stats
  final List<AnimeDetailsRatesScoresStatDTO?> ratesScoresStats;

  ///Anime rates statuses stats
  final List<AnimeDetailsRatesStatusesStatDTO?> ratesStatusesStats;

  ///Anime updated at
  final DateTime? updatedAt;

  ///Anime next episode at
  final dynamic nextEpisodeAt;

  ///Anime fan subbers
  final List<String>? fanSubbers;

  ///Anime fan dubbers
  final List<String>? fanDubbers;

  ///Anime licensors
  final List<dynamic> licensors;

  ///Anime genres
  final List<AnimeDetailsGenreDTO?> genres;

  ///Anime studios
  final List<AnimeDetailsStudioDTO?> studios;

  ///Anime videos
  final List<AnimeDetailsVideoDTO?> videos;

  ///Anime screenshots
  final List<AnimeDetailsScreenshotDTO?> screenshots;

  ///Anime user rate
  final dynamic userRate;
}
