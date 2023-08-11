import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/anime/data/data_sources/anime_remote_data_source.dart';
import 'package:shikimoriapp/feature/anime/data/dto/anime_dto.dart';
import 'package:shikimoriapp/feature/anime/data/mappers/anime_mapper.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';

///Anime remote data source implementation
class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  ///Need dio client to work
  AnimeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Anime>> getAnimes(
    int page, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
    String? season,
    String? status,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.getAnimes,
      queryParameters: {
        'order': order,
        'page': page,
        'limit': limit,
        'season': season,
        'status': status,
      },
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => AnimeDTO.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();
    } else {
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
    final response = await _dio.get(
      ApiEndpoints.getAnimes,
      queryParameters: {
        'search': phrase,
        'order': order,
        'limit': limit,
      },
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => AnimeDTO.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();
    } else {
      throw ServerException();
    }
  }
}
