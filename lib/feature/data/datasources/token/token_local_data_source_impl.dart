import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/token/token_local_data_source.dart';

///Token local data source implementation
class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  ///Need secure storage to work
  TokenLocalDataSourceImpl(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token).onError(
          (error, stackTrace) => SaveException(
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        );
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token).onError(
          (error, stackTrace) => SaveException(
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        );
  }

  @override
  Future<void> deleteTokens() async {
    await _storage.deleteAll().onError(
          (error, stackTrace) => SaveException(
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        );
  }
}
