import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_genre_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_image_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_rates_score_stat_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_rates_statuses_stat_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_screenshot_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_studio_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_video_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';

extension AnimeDetailsMapper on AnimeDetailsDTO {
  ///Convert from model to entity
  AnimeDetails toEntity() {
    return AnimeDetails(
      id: id,
      name: name,
      russian: russian,
      image: image?.toEntity(),
      url: url,
      kind: kind,
      score: score,
      status: status,
      episodes: episodes,
      episodesAired: episodesAired,
      airedOn: airedOn,
      releasedOn: releasedOn,
      rating: rating,
      english: english,
      japanese: japanese,
      duration: duration,
      description: description,
      descriptionHtml: descriptionHtml,
      descriptionSource: descriptionSource,
      franchise: franchise,
      favoured: favoured,
      anons: anons,
      ongoing: ongoing,
      threadId: threadId,
      topicId: topicId,
      ratesScoresStats: ratesScoresStats.map((e) => e?.toEntity()).toList(),
      ratesStatusesStats: ratesStatusesStats.map((e) => e?.toEntity()).toList(),
      genres: genres.map((e) => e?.toEntity()).toList(),
      studios: studios.map((e) => e?.toEntity()).toList(),
      videos: videos.map((e) => e?.toEntity()).toList(),
      screenshots: screenshots.map((e) => e?.toEntity()).toList(),
      userRate: userRate,
      updatedAt: updatedAt,
      nextEpisodeAt: nextEpisodeAt,
      synonyms: synonyms,
      myAnimeListId: myAnimeListId,
      fanSubbers: fanSubbers,
      fanDubbers: fanDubbers,
      licensors: licensors,
      licenseNameRu: licenseNameRu,
    );
  }
}
