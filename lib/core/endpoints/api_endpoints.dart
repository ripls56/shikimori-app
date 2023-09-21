import 'package:shikimoriapp/env/env.dart';

///Shikimori api endpoints
abstract class ApiEndpoints {
  static const String _host = Env.host;
  static const String _hostV2 = Env.hostV2;
  static const String _updateHost = Env.updateHost;

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

  ///Endpoint on _host/user_rates
  static String get userRates => '$_host/user_rates';

  ///Token endpoint
  static String get token => Env.tokenEndpoint;

  ///Endpoint on _host/users/whoami
  static String get creditional => '$_host/users/whoami';

  ///Endpoint on _host/comments
  static String get comments => '$_host/comments';

  ///Endpoint on _host/comments/$id
  static String commentsById(int id) => '$_host/comments/$id';

  ///Endpoint on _updateHost/update
  // TODO(ripls56): add version
  static String update(String version) => '$_updateHost/update';

  ///Endpoint on _updateHost/update/info
  static String get updateInformation => '$_updateHost/update/info';
}
