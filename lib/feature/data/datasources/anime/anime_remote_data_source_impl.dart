import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/data/datasources/anime/anime_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/anime/anime.dart';
import 'package:shikimoriapp/feature/data/models/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/data/models/related/related.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';

///Anime remote data source implementation
class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  ///Need dio client to work
  AnimeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<AnimeDetails> getAnimeById(int id) async {
    final response = await _dio.get(ApiEndpoints.animeById(id));
    if (response.statusCode == 200) {
      return AnimeDetailsModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Anime>> getAnimes(
    int page, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.getAnimes,
      queryParameters: {
        'order': order,
        'page': page,
        'limit': limit,
      },
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => AnimeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Video>> getVideos(int id) async {
    final response = await _dio.get(
      ApiEndpoints.animeVideos(id),
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Screenshot>> getScreenshots(int id) async {
    final response = await _dio.get(
      ApiEndpoints.animeScreenshots(id),
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => ScreenshotModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Related>> getRelatedAnime(int id) async {
    final response = await _dio.get(
      ApiEndpoints.animeRelateds(id),
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => RelatedModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      var a = ServerFailure();
      throw ServerException();
    }
  }

  @override
  Future<List<Anime>> getAnimesByName(
    String phrase, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
  }) async {
    var response = await _dio.get(
      ApiEndpoints.getAnimes,
      queryParameters: {
        'search': phrase,
        'order': order,
        'limit': limit,
      },
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => AnimeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
