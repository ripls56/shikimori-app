part 'genre.dart';
part 'image.dart';
part 'rates_score_stats.dart';
part 'rates_statuses_stats.dart';
part 'screenshot.dart';
part 'studio.dart';
part 'video.dart';

class AnimeDetails {
  AnimeDetails({
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

  final int id;
  final String name;
  final String russian;
  final Image image;
  final String url;
  final String kind;
  final String score;
  final String status;
  final int episodes;
  final int episodesAired;
  final DateTime airedOn;
  final DateTime releasedOn;
  final String rating;
  final List<String> english;
  final List<String> japanese;
  final List<String> synonyms;
  final dynamic licenseNameRu;
  final int duration;
  final String description;
  final String descriptionHtml;
  final dynamic descriptionSource;
  final String franchise;
  final bool favoured;
  final bool anons;
  final bool ongoing;
  final int threadId;
  final int topicId;
  final int myanimelistId;
  final List<RatesScoresStat> ratesScoresStats;
  final List<RatesStatusesStat> ratesStatusesStats;
  final DateTime updatedAt;
  final dynamic nextEpisodeAt;
  final List<String> fansubbers;
  final List<String> fandubbers;
  final List<dynamic> licensors;
  final List<Genre> genres;
  final List<Studio> studios;
  final List<Video> videos;
  final List<Screenshot> screenshots;
  final dynamic userRate;

  factory AnimeDetails.fromJson(Map<String, dynamic> json) => AnimeDetails(
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
        ratesScoresStats: List<RatesScoresStat>.from(
            json["rates_scores_stats"].map((x) => RatesScoresStat.fromJson(x))),
        ratesStatusesStats: List<RatesStatusesStat>.from(
            json["rates_statuses_stats"]
                .map((x) => RatesStatusesStat.fromJson(x))),
        updatedAt: DateTime.parse(json["updated_at"]),
        nextEpisodeAt: json["next_episode_at"],
        fansubbers: List<String>.from(json["fansubbers"].map((x) => x)),
        fandubbers: List<String>.from(json["fandubbers"].map((x) => x)),
        licensors: List<dynamic>.from(json["licensors"].map((x) => x)),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        studios:
            List<Studio>.from(json["studios"].map((x) => Studio.fromJson(x))),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        screenshots: List<Screenshot>.from(
            json["screenshots"].map((x) => Screenshot.fromJson(x))),
        userRate: json["user_rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "russian": russian,
        "image": image.toJson(),
        "url": url,
        "kind": kind,
        "score": score,
        "status": status,
        "episodes": episodes,
        "episodes_aired": episodesAired,
        "aired_on":
            "${airedOn.year.toString().padLeft(4, '0')}-${airedOn.month.toString().padLeft(2, '0')}-${airedOn.day.toString().padLeft(2, '0')}",
        "released_on":
            "${releasedOn.year.toString().padLeft(4, '0')}-${releasedOn.month.toString().padLeft(2, '0')}-${releasedOn.day.toString().padLeft(2, '0')}",
        "rating": rating,
        "english": List<dynamic>.from(english.map((x) => x)),
        "japanese": List<dynamic>.from(japanese.map((x) => x)),
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "license_name_ru": licenseNameRu,
        "duration": duration,
        "description": description,
        "description_html": descriptionHtml,
        "description_source": descriptionSource,
        "franchise": franchise,
        "favoured": favoured,
        "anons": anons,
        "ongoing": ongoing,
        "thread_id": threadId,
        "topic_id": topicId,
        "myanimelist_id": myanimelistId,
        "rates_scores_stats":
            List<dynamic>.from(ratesScoresStats.map((x) => x.toJson())),
        "rates_statuses_stats":
            List<dynamic>.from(ratesStatusesStats.map((x) => x.toJson())),
        "updated_at": updatedAt.toIso8601String(),
        "next_episode_at": nextEpisodeAt,
        "fansubbers": List<dynamic>.from(fansubbers.map((x) => x)),
        "fandubbers": List<dynamic>.from(fandubbers.map((x) => x)),
        "licensors": List<dynamic>.from(licensors.map((x) => x)),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "studios": List<dynamic>.from(studios.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "screenshots": List<dynamic>.from(screenshots.map((x) => x.toJson())),
        "user_rate": userRate,
      };
}
