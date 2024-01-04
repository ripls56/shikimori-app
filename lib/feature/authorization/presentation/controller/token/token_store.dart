import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/core/extension/string_extension.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/authorization/domain/models/user_auth.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/save_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/save_refresh_token.dart';

part 'token_store.g.dart';

class TokenStore = _TokenStoreBase with _$TokenStore;

abstract class _TokenStoreBase with Store {
  _TokenStoreBase(
    this._getAccessToken,
    this._saveAccessToken,
    this._saveRefreshToken,
  );

  final GetAccessToken _getAccessToken;
  final SaveAccessToken _saveAccessToken;
  final SaveRefreshToken _saveRefreshToken;

  @observable
  String? errorMessage;

  @observable
  UserAuth? userAuth;

  @action
  Future<void> getAccessToken(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final loadedOrFailure = await _getAccessToken.call(
      GetAccessTokenParams(
        grantType: Env.grantType,
        code: code,
        redirectUri: Env.redirectUri.toUri,
        identifier: Env.identifier,
        secret: Env.secret,
      ),
    );
    loadedOrFailure.fold(
      (error) => errorMessage = error.message,
      (loaded) {
        userAuth = loaded;
        _saveAccessToken.call(
          SaveAccessTokenParams(accessToken: loaded.accessToken!),
        );
        _saveRefreshToken.call(
          SaveRefreshTokenParams(refreshToken: loaded.refreshToken!),
        );
      },
    );
  }
}
