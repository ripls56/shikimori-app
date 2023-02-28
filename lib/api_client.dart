// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'feature/data/models/anime/anime.dart';
import 'feature/data/models/anime_details/anime_details.dart';
import 'feature/data/models/creditional/creditional.dart';
import 'feature/data/models/user_auth/user_auth.dart';
import 'feature/data/models/user_rate/user_rate.dart';

class ApiClient {
  late AuthorizationCodeGrant grant;
  late Uri authorizationUrl;
  static const shikimoriUrl = 'https://shikimori.one/';
  static const _host = 'https://shikimori.one/api';
  static const _hostV2 = 'https://shikimori.one/api/v2';
  final redirectUri =
      Uri.parse('https://shiki.dfgdf'); //urn:ietf:wg:oauth:2.0:oob
  final authorizationEndpoint =
      Uri.parse('https://shikimori.one/oauth/authorize');
  final tokenEndpoint = Uri.parse('https://shikimori.one/oauth/authorize/');
  static const _identifier = 'jWeRpE8bKQ6eT3fTw2yDYS3hup04Zx5v4CMJ9hMqDk4';
  static const _secret = 'jwKxAkVNoOvJqcgro1dsAndXQr0ijJAwxWlNy-ML-ic';
  String code = "";
  final Dio _dio = Dio();
  String accessToken = '';

  static final ApiClient _singleton = ApiClient._internal();

  ApiClient._internal() {
    grant = oauth2.AuthorizationCodeGrant(
        _identifier, authorizationEndpoint, tokenEndpoint,
        secret: _secret);

    authorizationUrl = grant.getAuthorizationUrl(redirectUri,
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

  factory ApiClient() {
    return _singleton;
  }
//perenes
  Future<String> getAccessToken() async {
    var response =
        await _dio.post('https://shikimori.one/oauth/token', queryParameters: {
      'grant_type': 'authorization_code',
      'client_id': _identifier,
      'client_secret': _secret,
      'code': code,
      'redirect_uri': redirectUri.toString()
    });
    if (response.statusCode == 200) {
      return UserAuthModel.fromJson(response.data).accessToken;
    } else {
      throw HttpException;
    }
  }

//perenec
  Future<CreditionalModel> getCreditionals() async {
    var token = await getAccessToken();
    _dio.options.headers = {
      'User-Agent': 'mpt coursework',
      'Authorization': 'Bearer $token'
    };
    var response = await _dio.get(
      '$_host/users/whoami',
    );
    if (response.statusCode == 200) {
      return CreditionalModel.fromJson(response.data);
    } else {
      throw HttpException;
    }
  }

  Future<void> addAnimeInRateList(UserRateModel rate) async {
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
    );
  }

  Future<List<UserRateModel>> getAnimeRateList(int id) async {
    final response = await _dio
        .get('$_hostV2/user_rates/', queryParameters: {'user_id': id});
    if (response.statusCode! == 200) {
      return (response.data as List<dynamic>)
          .map((e) => UserRateModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw HttpException;
    }
  }

  Future<List<AnimeModel>> getAnimes(int page,
      {String order = "ranked", int limit = 50}) async {
    var response = await _dio.get(
      '$_host/animes',
      queryParameters: {
        'order': order,
        'page': page,
        'limit': limit,
      },
    );
    return (response.data as List<dynamic>)
        .map((e) => AnimeModel.fromJson((e as Map<String, dynamic>)))
        .toList();
  }

  Future<AnimeDetailsModel> getAnimeById(int id) async {
    var response = await _dio.get('$_host/animes/$id');
    return AnimeDetailsModel.fromJson(response.data);
  }
}
