import 'package:dio/dio.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimori_app/auth.dart';

class ApiClient {
  late AuthorizationCodeGrant grant;

  late Uri authorizationUrl;

  ApiClient() {
    grant = oauth2.AuthorizationCodeGrant(
        identifier, authorizationEndpoint, tokenEndpoint,
        secret: secret);
    authorizationUrl = grant.getAuthorizationUrl(_redirectUri,
        scopes: ['user_rates', 'comments', 'topics']);
  }

  static const _host = 'https://shikimori.one/api';
  static const _hostV2 = 'https://shikimori.one/api/v2';

  final _redirectUri = Uri.parse('urn:ietf:wg:oauth:2.0:oob');

  final authorizationEndpoint =
      Uri.parse('https://shikimori.one/oauth/authorize');
  final tokenEndpoint = Uri.parse('https://shikimori.one/oauth/authorize/');

  static const identifier = 'jWeRpE8bKQ6eT3fTw2yDYS3hup04Zx5v4CMJ9hMqDk4';
  static const secret = 'jwKxAkVNoOvJqcgro1dsAndXQr0ijJAwxWlNy-ML-ic';

  String code = "";

  Future<String> getAccessToken() async {
    //var a = authorizationUrl.queryParameters;
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    var response =
        await dio.post('https://shikimori.one/oauth/token', queryParameters: {
      'grant_type': 'authorization_code',
      'client_id': identifier,
      'client_secret': secret,
      'code': code,
      'redirect_uri': _redirectUri.toString()
    });
    final String token = Auth.fromJson(response.data).accessToken;
    return token;
  }

  String accessToken = '';

  Future<void> getCreditionals() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    getAccessToken().then((value) async => {
          accessToken = value,
          await dio.get(
            '$_host/users/whoami',
            options: Options(
              headers: {
                'User-Agent': 'mpt coursework',
                'Authorization': 'Bearer $value'
              },
            ),
          ),
        });
  }

  Future<void> getRateList() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    await dio.post(
      '$_hostV2/user_rates/',
      data: {
        "user_rate": {
          "chapters": "4",
          "episodes": "2",
          "rewatches": "5",
          "score": "10",
          "status": "completed",
          "target_id": "15",
          "target_type": "Anime",
          "text": "test",
          "user_id": "1156346",
          "volumes": "3"
        }
      },
      options: Options(
        headers: {
          'User-Agent': 'mpt coursework',
          'Authorization': 'Bearer $accessToken'
        },
      ),
    );
  }
}
