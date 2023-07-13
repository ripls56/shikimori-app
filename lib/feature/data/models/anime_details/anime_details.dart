import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';

part 'genre.dart';
part 'image.dart';
part 'rates_score_stat.dart';
part 'rates_statuses_stat.dart';
part 'screenshot.dart';
part 'studio.dart';
part 'video.dart';

class AnimeDetailsModel extends AnimeDetails {
  const AnimeDetailsModel({
    required id,
    required name,
    required russian,
    required super.image,
    required url,
    required kind,
    required score,
    required status,
    required episodes,
    required episodesAired,
    required airedOn,
    required super.releasedOn,
    required rating,
    required english,
    required japanese,
    required synonyms,
    required duration,
    required description,
    required descriptionHtml,
    required franchise,
    required favoured,
    required anons,
    required ongoing,
    required threadId,
    required topicId,
    required myanimelistId,
    required ratesScoresStats,
    required ratesStatusesStats,
    required updatedAt,
    required fansubbers,
    required fandubbers,
    required licensors,
    required genres,
    required studios,
    required videos,
    required screenshots,
  }) : super(
          id: id,
          name: name,
          russian: russian,
          url: url,
          kind: kind,
          score: score,
          status: status,
          episodes: episodes,
          episodesAired: episodesAired,
          airedOn: airedOn,
          rating: rating,
          english: english,
          japanese: japanese,
          synonyms: synonyms,
          duration: duration,
          description: description,
          descriptionHtml: descriptionHtml,
          franchise: franchise,
          favoured: favoured,
          anons: anons,
          ongoing: ongoing,
          threadId: threadId,
          topicId: topicId,
          myanimelistId: myanimelistId,
          ratesScoresStats: ratesScoresStats,
          ratesStatusesStats: ratesStatusesStats,
          updatedAt: updatedAt,
          fanSubbers: fansubbers,
          fanDubbers: fandubbers,
          licensors: licensors,
          genres: genres,
          studios: studios,
          videos: videos,
          screenshots: screenshots,
        );

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) =>
      AnimeDetailsModel(
        id: json['id'],
        name: json['name'],
        russian: json['russian'],
        image: ImageModel.fromJson(json['image']),
        url: json['url'],
        kind: json['kind'],
        score: json['score'],
        status: json['status'],
        episodes: json['episodes'],
        episodesAired: json['episodes_aired'],
        airedOn: DateTime.parse(json['aired_on']),
        releasedOn: json['released_on'] != null
            ? DateTime.parse(json['released_on'])
            : null,
        rating: json['rating'],
        english: json['english'] != null
            ? List<String?>.from(json['english'].map((x) => x))
            : null,
        japanese: json['japanese'] != null
            ? List<String>.from(json['japanese'].map((x) => x))
            : null,
        synonyms: json['synonyms'] != null
            ? List<String>.from(json['synonyms'].map((x) => x))
            : null,
        licenseNameRu: json['license_name_ru'],
        duration: json['duration'],
        description: json['description'],
        descriptionHtml: json['description_html'],
        descriptionSource: json['description_source'],
        franchise: json['franchise'],
        favoured: json['favoured'],
        anons: json['anons'],
        ongoing: json['ongoing'],
        threadId: json['thread_id'],
        topicId: json['topic_id'],
        myanimelistId: json['myanimelist_id'],
        ratesScoresStats: json['rates_scores_stats'] != null
            ? List<RatesScoresStat>.from(
                json['rates_scores_stats'].map(RatesScoresStatModel.fromJson),
              )
            : null,
        ratesStatusesStats: json['rates_statuses_stats'] != null
            ? List<RatesStatusesStat>.from(
                json['rates_statuses_stats']
                    .map(RatesStatusesStatModel.fromJson),
              )
            : null,
        updatedAt: DateTime.parse(json['updated_at']),
        nextEpisodeAt: json['next_episode_at'],
        fansubbers: json['fansubbers'] != null
            ? List<String>.from(json['fansubbers'].map((x) => x))
            : null,
        fandubbers: json['fandubbers'] != null
            ? List<String>.from(json['fandubbers'].map((x) => x))
            : null,
        licensors: json['licensors'] != null
            ? List<String>.from(json['licensors'].map((x) => x))
            : null,
        genres: json['genres'] != null
            ? List<Genre>.from(
                json['genres'].map(GenreModel.fromJson),
              )
            : null,
        studios: json['studios'] != null
            ? List<Studio>.from(
                json['studios'].map(StudioModel.fromJson),
              )
            : null,
        videos: json['videos'] != null
            ? List<Video>.from(
                json['videos'].map(VideoModel.fromJson),
              )
            : null,
        screenshots: json['screenshots'] != null
            ? List<Screenshot>.from(
                json['screenshots'].map(ScreenshotModel.fromJson),
              )
            : null,
        userRate: json['user_rate'],
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
