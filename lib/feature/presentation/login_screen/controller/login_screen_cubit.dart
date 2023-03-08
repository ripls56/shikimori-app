// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/feature/domain/use_cases/access_token/get_access_token.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/view/home_screen.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:oauth2/oauth2.dart';
part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit(this.getAccessToken) : super(LoginScreenEmpty());
  final GetAccessToken getAccessToken;

  login(BuildContext context) async {
    try {
      emit(LoginScreenEmpty());

      var grant = AuthorizationCodeGrant(
          IDENTIFIER, AUTHORIZATION_ENDPOINT, TOKEN_ENDPOINT,
          secret: SECRET);

      var authorizationUrl = grant.getAuthorizationUrl(REDIRECT_URL,
          scopes: ['user_rates', 'comments', 'topics']);

      launchUrl((authorizationUrl),
          mode: LaunchMode.externalNonBrowserApplication);

      linkStream.listen((String? link) async {
        if (link == null) return;
        if (link.contains('code')) {
          var token = Uri.parse(link).queryParameters['code']!;
          debugPrint(token);
          final loadedOrFailure = await getAccessToken.call(
              GetAccessTokenParams(
                  grantType: GRANT_TYPE,
                  code: token,
                  redirectUri: REDIRECT_URL,
                  identifier: IDENTIFIER,
                  secret: SECRET));
          loadedOrFailure.fold(
            (error) => {emit(LoginScreenEmpty())},
            (loaded) => {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) {
                  ACCESS_TOKEN = loaded.accessToken;
                  return const HomeScreen();
                },
              ), (Route<dynamic> route) => false)
            },
          );
        }
      }, onError: (err) {
        Fluttertoast.showToast(msg: err);
      });
    } catch (_) {
      emit(LoginScreenEmpty());
    }
  }
}
