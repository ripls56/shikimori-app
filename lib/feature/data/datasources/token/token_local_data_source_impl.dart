import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shikimoriapp/feature/data/datasources/token/token_local_data_source.dart';

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final FlutterSecureStorage storage;

  TokenLocalDataSourceImpl(this.storage);
  @override
  Future<void> saveAccessToken(String token) async {
    await storage.write(key: 'access_token', value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await storage.write(key: 'refresh_token', value: token);
  }
}
