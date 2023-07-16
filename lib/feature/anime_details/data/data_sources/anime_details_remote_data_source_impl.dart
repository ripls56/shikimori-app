import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/anime_details/data/data_sources/anime_details_remote_data_source.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_screenshot_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/dto/anime_details_video_dto.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_screenshot_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/data/mappers/anime_details_video_mapper.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_video.dart';
import 'package:shikimoriapp/feature/related/domain/models/related.dart';

///Anime details data source implementation
class AnimeDetailsDataSourceImpl implements AnimeDetailsRemoteDataSource {
  ///Constructor
  AnimeDetailsDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<AnimeDetails> getAnimeById(int id) async {
    final response = await _dio.get(ApiEndpoints.animeById(id));
    if (response.statusCode == 200) {
      return AnimeDetailsDTO.fromJson(response.data as Map<String, dynamic>)
          .toEntity();
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
      // return (response.data as List<dynamic>)
      //     .map((e) => RelatedModel.fromJson(e as Map<String, dynamic>))
      //     .toList();
      throw UnimplementedError();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<AnimeDetailsVideo>> getVideos(int id) async {
    final response = await _dio.get(
      ApiEndpoints.animeVideos(id),
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map(
            (e) => AnimeDetailsVideoDTO.fromJson(e as Map<String, dynamic>)
                .toEntity(),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<AnimeDetailsScreenshot>> getScreenshots(int id) async {
    final response = await _dio.get(
      ApiEndpoints.animeScreenshots(id),
    );
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map(
            (e) => AnimeDetailsScreenshotDTO.fromJson(e as Map<String, dynamic>)
                .toEntity(),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
