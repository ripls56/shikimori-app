import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/profile/data/datasources/user_rate_remote_data_source.dart';
import 'package:shikimoriapp/feature/profile/data/dto/user_rate_dto.dart';
import 'package:shikimoriapp/feature/profile/data/mappers/user_rate_mapper.dart';
import 'package:shikimoriapp/feature/profile/domain/models/user_rate.dart';

///User rates remote data source implementation
class UserRateRemoteDataSourceImpl implements UserRateRemoteDataSource {
  ///Need dio client to work
  UserRateRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<UserRate>> addAnimeInUserRates(
    UserRate rate,
    String token,
  ) async {
    // TODO(ripls56): Пофиксить использование сервис локатора (13/07/23)
    final response = await _dio.post(
      ApiEndpoints.userRates,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        'user_rate': {
          'chapters': rate.chapters,
          'episodes': rate.episodes,
          'rewatches': rate.rewatches,
          'score': rate.score,
          'status': rate.status,
          'target_id': rate.targetId,
          'target_type': rate.targetType,
          'text': rate.text,
          'user_id': rate.userId,
          'volumes': rate.volumes
        }
      },
    );
    if (response.statusCode! == 200) {
      return (response.data as List<dynamic>)
          .map(
            (e) => UserRateDTO.fromJson(e as Map<String, dynamic>).toEntity(),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserRate> getUserRateById(int userId, int animeId) async {
    // TODO: implement getAllUserRates
    throw UnimplementedError();
  }

  @override
  Future<List<UserRate>> getAllUserRates(int userId) async {
    final response = await _dio
        .get(ApiEndpoints.userRates, queryParameters: {'user_id': userId});
    if (response.statusCode! == 200) {
      return (response.data as List<dynamic>)
          .map(
            (e) => UserRateDTO.fromJson(e as Map<String, dynamic>).toEntity(),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
