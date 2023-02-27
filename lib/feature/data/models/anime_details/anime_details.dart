import 'package:equatable/equatable.dart';
import 'package:shikimori_app/feature/domain/entities/anime_details/anime_details.dart';
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
    required image,
    required url,
    required kind,
    required score,
    required status,
    required episodes,
    required episodesAired,
    required airedOn,
    required releasedOn,
    required rating,
    required english,
    required japanese,
    required synonyms,
    licenseNameRu,
    required duration,
    required description,
    required descriptionHtml,
    descriptionSource,
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
    nextEpisodeAt,
    required fansubbers,
    required fandubbers,
    required licensors,
    required genres,
    required studios,
    required videos,
    required screenshots,
    userRate,
  }) : super(
            id: id,
            name: name,
            russian: russian,
            image: image,
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
            fansubbers: fansubbers,
            fandubbers: fandubbers,
            licensors: licensors,
            genres: genres,
            studios: studios,
            videos: videos,
            screenshots: screenshots);

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) =>
      AnimeDetailsModel(
        id: json["id"],
        name: json["name"],
        russian: json["russian"],
        image: Image.fromJson(json["image"]),
        url: json["url"],
        kind: json["kind"],
        score: json["score"],
        status: json["status"],
        episodes: json["episodes"],
        episodesAired: json["episodes_aired"],
        airedOn: DateTime.parse(json["aired_on"]),
        releasedOn: DateTime.parse(json["released_on"]),
        rating: json["rating"],
        english: List<String>.from(json["english"].map((x) => x)),
        japanese: List<String>.from(json["japanese"].map((x) => x)),
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        licenseNameRu: json["license_name_ru"],
        duration: json["duration"],
        description: json["description"],
        descriptionHtml: json["description_html"],
        descriptionSource: json["description_source"],
        franchise: json["franchise"],
        favoured: json["favoured"],
        anons: json["anons"],
        ongoing: json["ongoing"],
        threadId: json["thread_id"],
        topicId: json["topic_id"],
        myanimelistId: json["myanimelist_id"],
        ratesScoresStats: List<RatesScoresStat>.from(json["rates_scores_stats"]
            .map((x) => RatesScoresStatModel.fromJson(x))),
        ratesStatusesStats: List<RatesStatusesStat>.from(
            json["rates_statuses_stats"]
                .map((x) => RatesStatusesStatModel.fromJson(x))),
        updatedAt: DateTime.parse(json["updated_at"]),
        nextEpisodeAt: json["next_episode_at"],
        fansubbers: List<String>.from(json["fansubbers"].map((x) => x)),
        fandubbers: List<String>.from(json["fandubbers"].map((x) => x)),
        licensors: List<dynamic>.from(json["licensors"].map((x) => x)),
        genres:
            List<Genre>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        studios: List<Studio>.from(
            json["studios"].map((x) => StudioModel.fromJson(x))),
        videos:
            List<Video>.from(json["videos"].map((x) => VideoModel.fromJson(x))),
        screenshots: List<Screenshot>.from(
            json["screenshots"].map((x) => ScreenshotModel.fromJson(x))),
        userRate: json["user_rate"],
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
