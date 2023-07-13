import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_genre.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_image.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_rates_score_stat.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_rates_statuses_stat.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_studio.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_video.dart';

///Anime details model
class AnimeDetails extends Equatable {
  ///Constructor
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
    required this.licenseNameRu,
    required this.descriptionSource,
    required this.nextEpisodeAt,
    required this.userRate,
  });

  ///Anime id
  final int? id;

  ///Anime name
  final String? name;

  ///Anime russian name
  final String? russian;

  ///Anime image
  final AnimeDetailsImage? image;

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
  final List<AnimeDetailsRatesScoresStat?> ratesScoresStats;

  ///Anime rates statuses stats
  final List<AnimeDetailsRatesStatusesStat?> ratesStatusesStats;

  ///Anime updated at
  final DateTime? updatedAt;

  ///Anime next episode at
  final dynamic nextEpisodeAt;

  ///Anime fan subbers
  final List<String?> fanSubbers;

  ///Anime fan dubbers
  final List<String?> fanDubbers;

  ///Anime licensors
  final List<dynamic> licensors;

  ///Anime genres
  final List<AnimeDetailsGenre?> genres;

  ///Anime studios
  final List<AnimeDetailsStudio?> studios;

  ///Anime videos
  final List<AnimeDetailsVideo?> videos;

  ///Anime screenshots
  final List<AnimeDetailsScreenshot?> screenshots;

  ///Anime user rate
  final dynamic userRate;

  @override
  List<Object?> get props => [
        id,
        name,
        russian,
        image,
        url,
        kind,
        score,
        status,
        episodes,
        episodesAired,
        airedOn,
        releasedOn,
        rating,
        english,
        japanese,
        synonyms,
        licenseNameRu,
        duration,
        description,
        descriptionHtml,
        descriptionSource,
        franchise,
        favoured,
        anons,
        ongoing,
        threadId,
        topicId,
        myAnimeListId,
        ratesScoresStats,
        ratesStatusesStats,
        updatedAt,
        nextEpisodeAt,
        fanSubbers,
        fanDubbers,
        licensors,
        genres,
        studios,
        videos,
        screenshots,
        userRate,
      ];
}
