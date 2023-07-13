import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/user_rate/user_rate_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/user_rate/user_rate.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/entities/user_rate/user_rate.dart';
import 'package:shikimoriapp/injection.container.dart' as di;

///User rates remote data source implementation
class UserRateRemoteDataSourceImpl implements UserRateRemoteDataSource {
  ///Need dio client to work
  UserRateRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<UserRate>> addAnimeInUserRates(UserRate rate) async {
    // TODO(ripls56): Пофиксить использование сервис локатора (13/07/23)
    _dio.options.headers
        .addAll({'Authorization': 'Bearer ${di.sl<UserAuth>().accessToken}'});
    final response = await _dio.post(
      ApiEndpoints.userRates,
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
          .map((e) => UserRateModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
    //TODO Распарсить модель тут надо (хз надо ли, потом чекнуть надо)
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
          .map((e) => UserRateModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
