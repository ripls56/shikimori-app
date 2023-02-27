// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimori_app/core/error/exception.dart';
import 'package:shikimori_app/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimori_app/feature/data/models/user_auth/user_auth.dart';

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  final _dio = Dio();
  UserAuthRemoteDataSourceImpl() {
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
  Future<UserAuthModel> auth(
      String identifier, String secret, String code, Uri redirectUri) async {
    var response =
        await _dio.post('https://shikimori.one/oauth/token', queryParameters: {
      'grant_type': 'authorization_code',
      'client_id': identifier,
      'client_secret': secret,
      'code': code,
      'redirect_uri': redirectUri.toString()
    });
    if (response.statusCode == 200) {
      return UserAuthModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
