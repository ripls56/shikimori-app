// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/user_rate/user_rate_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/user_rate/user_rate.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/entities/user_rate/user_rate.dart';
import 'package:shikimoriapp/injection.container.dart' as di;

class UserRateRemoteDataSourceImpl implements UserRateRemoteDataSource {
  final Dio dio;
  UserRateRemoteDataSourceImpl(this.dio) {
    dio.options.headers
        .addAll({'Authorization': 'Bearer ${di.sl<UserAuth>().accessToken}'});
  }

  @override
  Future<List<UserRate>> addAnimeInUserRates(UserRate rate) async {
    var response = await dio.post(
      '$HOSTV2/user_rates/',
      data: {
        "user_rate": {
          "chapters": rate.chapters,
          "episodes": rate.episodes,
          "rewatches": rate.rewatches,
          "score": rate.score,
          "status": rate.status,
          "target_id": rate.targetId,
          "target_type": rate.targetType,
          "text": rate.text,
          "user_id": rate.userId,
          "volumes": rate.volumes
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
    final response = await dio
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
