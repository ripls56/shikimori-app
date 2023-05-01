import 'package:dio/dio.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/user_auth/user_auth_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/user_auth/user_auth.dart';

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  final Dio dio;
  UserAuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserAuthModel> getAccessToken(String grantType, String identifier,
      String secret, String code, Uri redirectUri) async {
    var response = await dio.post(TOKEN_ENDPOINT.toString(), queryParameters: {
      'grant_type': grantType,
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
