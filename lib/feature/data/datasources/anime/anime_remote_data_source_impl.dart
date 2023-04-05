import 'package:dio/dio.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/models/anime/anime.dart';
import 'package:shikimoriapp/feature/data/models/related/related.dart';
import 'package:shikimoriapp/feature/data/models/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';
import 'anime_remote_data_source.dart';

class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  final Dio dio;
  AnimeRemoteDataSourceImpl(this.dio);

  @override
  Future<AnimeDetails> getAnimeById(int id) async {
    var response = await dio.get('$HOST/animes/$id');
    if (response.statusCode == 200) {
      return AnimeDetailsModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Anime>> getAnimes(int page,
      {String? order = "ranked", int? limit = 50, int? score}) async {
    var response = await dio.get(
      '$HOST/animes',
      queryParameters: {
        'order': order,
        'page': page,
        'limit': limit,
      },
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => AnimeModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Video>> getVideos(int id) async {
    var response = await dio.get(
      '$HOST/animes/$id/videos',
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => VideoModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Screenshot>> getScreenshots(int id) async {
    var response = await dio.get(
      '$HOST/animes/$id/screenshots',
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => ScreenshotModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Related>> getRelatedAnime(int id) async {
    var response = await dio.get(
      '$HOST/animes/$id/related',
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => RelatedModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Anime>> getAnimesByName(String phrase,
      {String? order = "ranked", int? limit = 50, int? score}) async {
    var response = await dio.get(
      '$HOST/animes',
      queryParameters: {
        'search': phrase,
        'order': order,
        'limit': limit,
      },
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => AnimeModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
