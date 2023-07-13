import 'package:shikimoriapp/env/env.dart';

abstract class ApiEndpoints {
  static const String _host = Env.host;
  static const String _hostV2 = Env.hostV2;

  ///Endpoint on _host/animes/
  static String get getAnimes => '$_host/animes';

  ///Endpoint on _host/animes/$id
  static String animeById(int id) => '$_host/animes/$id';

  ///Endpoint on _host/animes/$id/videos
  static String animeVideos(int id) => '$_host/animes/$id/videos';

  ///Endpoint on _host/animes/$id/screenshots
  static String animeScreenshots(int id) => '$_host/animes/$id/screenshots';

  ///Endpoint on _host/animes/$id/related
  static String animeRelateds(int id) => '$_host/animes/$id/related';

  ///Endpoint on _host/characters/$id
  static String characterById(int id) => '$_host/characters/$id';

  static String get userRates => '$_host/user_rates/';

  static String get token => Env.tokenEndpoint;

  static String get creditional => '$_host/users/whoami';
}
