import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/authorization/data/datasources/token_local_data_source.dart';

///Token local data source implementation
class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  ///Need secure storage to work
  TokenLocalDataSourceImpl(this._storage);

  final FlutterSecureStorage _storage;

  final String _accessTokenKey = 'access_token';
  final String _refreshTokenKey = 'refresh_token';

  @override
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token).onError(
          (error, stackTrace) => throw SaveException(
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        );
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token).onError(
          (error, stackTrace) => throw SaveException(
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        );
  }

  @override
  Future<void> deleteTokens() async {
    await _storage.deleteAll().onError(
          (error, stackTrace) => throw SaveException(
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        );
  }

  @override
  Future<String> getAccessToken() async {
    final token = await _storage.read(key: _accessTokenKey).onError(
          (error, stackTrace) => throw GetTokenException(
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        );
    if (token != null) {
      return token;
    } else {
      throw GetTokenException(
        message: 'Token is null',
        stackTrace: 'Token is null',
      );
    }
  }

  @override
  Future<String> getRefreshToken() async {
    final token = await _storage.read(key: _accessTokenKey).onError(
          (error, stackTrace) => throw GetTokenException(
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        );
    if (token != null) {
      return token;
    } else {
      throw GetTokenException(
        message: 'Token is null',
        stackTrace: 'Token is null',
      );
    }
  }
}
