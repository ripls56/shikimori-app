// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/models/anime/anime.dart';
import 'package:shikimoriapp/feature/data/models/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'anime_remote_data_source.dart';

class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  final _dio = Dio();
  AnimeRemoteDataSourceImpl() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    _dio.options.headers = {
      'User-Agent': 'mpt coursework',
      'Authorization': 'Bearer $ACCESS_TOKEN'
    };
  }

  @override
  Future<AnimeDetails> getAnimeById(int id) async {
    var response = await _dio.get('$HOST/animes/$id');
    if (response.statusCode == 200) {
      return AnimeDetailsModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Anime>> getAnimes(int page,
      {String? order = "ranked", int? limit = 50, int? score}) async {
    var response = await _dio.get(
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
}
