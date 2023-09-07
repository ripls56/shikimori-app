import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/core/extension/string_extension.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/authorization/domain/models/user_auth.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/save_access_token.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/save_refresh_token.dart';
import 'package:shikimoriapp/injection.container.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit(
    this.getAccessToken,
    this.saveAccessToken,
    this.saveRefreshToken,
  ) : super(LoginScreenEmpty());
  final GetAccessToken getAccessToken;
  final SaveAccessToken saveAccessToken;
  final SaveRefreshToken saveRefreshToken;

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
          mode: LaunchMode.externalNonBrowserApplication,
        );
        linkStream.listen(
          (String? link) async {
            if (link == null) return;
            if (link.contains('code')) {
              final token = Uri.parse(link).queryParameters['code']!;
              final loadedOrFailure = await getAccessToken.call(
                GetAccessTokenParams(
                  grantType: Env.grantType,
                  code: token,
                  redirectUri: Env.redirectUri.toUri,
                  identifier: Env.identifier,
                  secret: Env.secret,
                ),
              );
              loadedOrFailure.fold(
                (error) => emit(LoginScreenEmpty()),
                (loaded) {
                  if (sl.isRegistered<UserAuth>()) {
                    sl.unregister<UserAuth>();
                  }
                  sl.registerSingleton<UserAuth>(loaded);
                  saveAccessToken.call(
                    SaveAccessTokenParams(accessToken: loaded.accessToken!),
                  );
                  saveRefreshToken.call(
                    SaveRefreshTokenParams(refreshToken: loaded.refreshToken!),
                  );
                  emit(LoginScreenLoaded());
                },
              );
            }
          },
          onError: (err, s) {
            throw AuthException(
              message: err.toString(),
              stackTrace: s.toString(),
            );
          },
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
    if (await sl<FlutterSecureStorage>().read(key: 'access_token') == null) {
      return false;
    }
    if (await sl<FlutterSecureStorage>().read(key: 'refresh_token') == null) {
      return false;
    }
    return true;
  }
}
