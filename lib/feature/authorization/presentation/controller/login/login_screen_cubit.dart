import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shikimoriapp/core/extension/string_extension.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/save_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/save_refresh_token.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_screen_state.dart';

///Cubit for login screen
class LoginScreenCubit extends Cubit<LoginScreenState> {
  ///Constructor
  LoginScreenCubit(
    this._getAccessToken,
    this._saveAccessToken,
    this._saveRefreshToken,
    this._secureStorage,
  ) : super(LoginScreenEmpty());
  final GetAccessToken _getAccessToken;
  final SaveAccessToken _saveAccessToken;
  final SaveRefreshToken _saveRefreshToken;

  final FlutterSecureStorage _secureStorage;

  ///Open oauth2 authorization link, listen for redirect and save tokens
  Future<void> login() async {
    try {
      emit(LoginScreenEmpty());
      final grant = AuthorizationCodeGrant(
        Env.identifier,
        Env.authorizationEndpoint.toUri,
        Env.tokenEndpoint.toUri,
        secret: Env.secret,
      );

      final authorizationUrl = grant.getAuthorizationUrl(
        Env.redirectUri.toUri,
        scopes: ['user_rates', 'comments', 'topics'],
      );

      if (!await checkTokensExist()) {
        FlutterNativeSplash.remove();
        await launchUrl(
          authorizationUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        emit(
          LoginScreenLoaded(),
        );
        FlutterNativeSplash.remove();
      }
    } catch (_) {
      FlutterNativeSplash.remove();
      emit(LoginScreenEmpty());
      rethrow;
    }
  }

  ///Check tokens in storage
  Future<bool> checkTokensExist() async {
    if (await _secureStorage.read(key: 'access_token') == null) {
      return false;
    }
    if (await _secureStorage.read(key: 'refresh_token') == null) {
      return false;
    }
    return true;
  }
}
