import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/creditional/creditional.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/use_cases/access_token/refresh_access_token.dart';
import 'package:shikimoriapp/injection.container.dart' as di;
import 'package:shikimoriapp/injection.container.dart';

class CreditionalRemoteDataSourceImpl implements CreditionalRemoteDataSource {
  final Dio dio;
  CreditionalRemoteDataSourceImpl(this.dio);

  @override
  Future<Creditional> getCreditionals(String token) async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.response?.statusCode == 400) {
            if (e.response?.data['error'] == 'invalid_grant') {
              handler.next(
                DioError.requestCancelled(
                    requestOptions: RequestOptions(), reason: 'invalid_grant'),
              );
            }
          }
          if (e.response?.statusCode == 401) {
            if (e.response?.data['error'] == 'invalid_token') {
              final loadedOrFailed = await sl<RefreshAccessToken>().call(
                RefreshAccessTokenParams(
                  grantType: 'refresh_token',
                  identifier: IDENTIFIER,
                  secret: SECRET,
                  refreshToken: sl<UserAuth>().refreshToken!,
                ),
              );
              loadedOrFailed.fold(
                (error) {
                  handler.next(
                    DioError.requestCancelled(
                        requestOptions: RequestOptions(),
                        reason: 'invalid_grant'),
                  );
                },
                (loaded) {
                  sl<FlutterSecureStorage>()
                      .write(key: 'access_token', value: loaded.accessToken);
                  sl<FlutterSecureStorage>()
                      .write(key: 'refresh_token', value: loaded.refreshToken);
                  if (di.sl.isRegistered<UserAuth>()) {
                    di.sl.unregister<UserAuth>();
                  }
                  di.sl.registerSingleton<UserAuth>(loaded);
                },
              );
            }
          }
        },
      ),
    );
    var response = await dio.get(
      '$HOST/users/whoami',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${di.sl<UserAuth>().accessToken}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return CreditionalModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
