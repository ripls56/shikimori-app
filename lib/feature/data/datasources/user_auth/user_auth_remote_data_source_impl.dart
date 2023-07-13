import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';

///User auth remote data source implementation
class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  ///Need http client to work
  UserAuthRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<UserAuthModel> getAccessToken(
    String grantType,
    String identifier,
    String secret,
    String code,
    Uri redirectUri,
  ) async {
    final response = await _dio.post(
      ApiEndpoints.token,
      queryParameters: {
        'grant_type': grantType,
        'client_id': identifier,
        'client_secret': secret,
        'code': code,
        'redirect_uri': redirectUri.toString()
      },
    );
    if (response.statusCode == 200) {
      return UserAuthModel.fromJson(response.data as Map<String, dynamic>);
    } else if (response.statusCode! > 499 && response.statusCode! < 599) {
      throw ServerException();
    } else {
      throw ClientException();
    }
  }

  @override
  Future<UserAuth> refreshAccessToken(
    String grantType,
    String identifier,
    String secret,
    String refreshToken,
  ) async {
    final response = await _dio.post(
      ApiEndpoints.token,
      queryParameters: {
        'grant_type': grantType,
        'client_id': identifier,
        'client_secret': secret,
        'refresh_token': refreshToken
      },
    );
    if (response.statusCode == 200) {
      return UserAuthModel.fromJson(response.data as Map<String, dynamic>);
    } else if (response.statusCode! > 499 && response.statusCode! < 599) {
      throw ServerException();
    } else {
      throw ClientException();
    }
  }
}
