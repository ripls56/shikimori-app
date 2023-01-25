import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimori_app/models/auth.dart';
import 'package:shikimori_app/models/user_rate.dart';

class ApiClient {
  late AuthorizationCodeGrant grant;

  late Uri authorizationUrl;

  ApiClient() {
    grant = oauth2.AuthorizationCodeGrant(
        identifier, authorizationEndpoint, tokenEndpoint,
        secret: secret);

    authorizationUrl = grant.getAuthorizationUrl(_redirectUri,
        scopes: ['user_rates', 'comments', 'topics']);

    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
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

  final Dio _dio = Dio();

  String accessToken = '';

  Future<String> getAccessToken() async {
    //var a = authorizationUrl.queryParameters
    var response =
        await _dio.post('https://shikimori.one/oauth/token', queryParameters: {
      'grant_type': 'authorization_code',
      'client_id': identifier,
      'client_secret': secret,
      'code': code,
      'redirect_uri': _redirectUri.toString()
    });
    final String token = Auth.fromJson(response.data).accessToken;
    return token;
  }

  Future<void> getCreditionals() async {
    getAccessToken().then(
      (value) async => {
        accessToken = value,
        await _dio.get(
          '$_host/users/whoami',
          options: Options(
            headers: {
              'User-Agent': 'mpt coursework',
              'Authorization': 'Bearer $value'
            },
          ),
        ),
      },
    );
  }

  Future<void> addAnimeInRateList(UserRate rate) async {
    await _dio.post(
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

  Future<List<UserRate>> getAnimeRateList(int id) async {
    final response = await _dio
        .get('$_hostV2/user_rates/', queryParameters: {'user_id': id});
    if (response.statusCode! == 200) {
      return (response.data as List<dynamic>)
          .map((e) => UserRate.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw HttpException;
    }
  }

  Future<void> getAnimeById(int id) async {
    await _dio.get('$_host/animes/53111');
  }
}
