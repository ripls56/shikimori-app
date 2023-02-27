// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimori_app/constants.dart';
import 'package:shikimori_app/core/error/exception.dart';
import 'package:shikimori_app/feature/data/datasources/user_rate/user_rate_remote_data_source.dart';
import 'package:shikimori_app/feature/data/models/user_rate/user_rate.dart';
import 'package:shikimori_app/feature/domain/entities/user_rate/user_rate.dart';

class UserRateRemoteDataSourceImpl implements UserRateRemoteDataSource {
  final _dio = Dio();
  UserRateRemoteDataSourceImpl() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  @override
  Future<List<UserRate>> addAnimeInUserRates(UserRate rate) async {
    var response = await _dio.post(
      '$HOSTV2/user_rates/',
      data: {
        "user_rate": {
          "chapters": "4",
          "episodes": "2",
          "rewatches": "5",
          "score": "10",
          "status": "completed",
          "target_id": "15",
          "target_type": "Anime",
          "text": "test",
          "user_id": "1156346",
          "volumes": "3"
        }
      },
    );
    if (response.statusCode! == 200) {
      return (response.data as List<dynamic>)
          .map((e) => UserRateModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
    //TODO Распарсить модель тут надо
  }

  @override
  Future<UserRate> getUserRateById(int userId, int animeId) async {
    // TODO: implement getAllUserRates
    throw UnimplementedError();
  }

  @override
  Future<List<UserRate>> getAllUserRates(int userId) async {
    final response = await _dio
        .get('$HOSTV2/user_rates/', queryParameters: {'user_id': userId});
    if (response.statusCode! == 200) {
      return (response.data as List<dynamic>)
          .map((e) => UserRateModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
