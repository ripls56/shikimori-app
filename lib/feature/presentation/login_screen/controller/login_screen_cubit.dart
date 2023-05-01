import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/data/models/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/use_cases/access_token/get_access_token.dart';
import 'package:shikimoriapp/feature/domain/use_cases/save_tokens/save_access_token.dart';
import 'package:shikimoriapp/feature/domain/use_cases/save_tokens/save_refresh_token.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shikimoriapp/injection.container.dart' as di;
part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  final GetAccessToken getAccessToken;
  final SaveAccessToken saveAccessToken;
  final SaveRefreshToken saveRefreshToken;

  LoginScreenCubit(
      this.getAccessToken, this.saveAccessToken, this.saveRefreshToken)
      : super(LoginScreenEmpty());

  void login() async {
    try {
      emit(LoginScreenEmpty());
      var grant = AuthorizationCodeGrant(
          IDENTIFIER, AUTHORIZATION_ENDPOINT, TOKEN_ENDPOINT,
          secret: SECRET);

      var authorizationUrl = grant.getAuthorizationUrl(REDIRECT_URL,
          scopes: ['user_rates', 'comments', 'topics']);

      if (!await checkTokensExist()) {
        FlutterNativeSplash.remove();
        launchUrl((authorizationUrl),
            mode: LaunchMode.externalNonBrowserApplication);
        linkStream.listen((String? link) async {
          if (link == null) return;
          if (link.contains('code')) {
            var token = Uri.parse(link).queryParameters['code']!;
            final loadedOrFailure = await getAccessToken.call(
              GetAccessTokenParams(
                  grantType: GRANT_TYPE,
                  code: token,
                  redirectUri: REDIRECT_URL,
                  identifier: IDENTIFIER,
                  secret: SECRET),
            );
            loadedOrFailure.fold(
              (error) => emit(LoginScreenEmpty()),
              (loaded) {
                if (di.sl.isRegistered<UserAuth>()) {
                  di.sl.unregister<UserAuth>();
                }
                di.sl.registerSingleton<UserAuth>(loaded);
                saveAccessToken.call(
                    SaveAccessTokenParams(accessToken: loaded.accessToken!));
                saveRefreshToken.call(
                    SaveRefreshTokenParams(refreshToken: loaded.refreshToken!));
                emit(LoginScreenLoaded());
              },
            );
          }
        }, onError: (err) {
          Fluttertoast.showToast(msg: err);
        });
      } else {
        var accessToken =
            await di.sl<FlutterSecureStorage>().read(key: 'access_token');
        var refreshToken =
            await di.sl<FlutterSecureStorage>().read(key: 'refresh_token');
        var model = UserAuthModel(
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenType: "Bearer",
            scope: null,
            createdAt: null,
            expireIn: null);
        if (di.sl.isRegistered<UserAuth>()) {
          di.sl.unregister<UserAuth>();
        }
        di.sl.registerSingleton<UserAuth>(model);
        emit(
          LoginScreenLoaded(),
        );
        FlutterNativeSplash.remove();
      }
    } catch (_) {
      FlutterNativeSplash.remove();
      emit(LoginScreenEmpty());
    }
  }

  Future<bool> checkTokensExist() async {
    if (await di.sl<FlutterSecureStorage>().read(key: 'access_token') == null) {
      return false;
    }
    if (await di.sl<FlutterSecureStorage>().read(key: 'refresh_token') ==
        null) {
      return false;
    }
    return true;
  }
}
