import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SHIKIMORI_URL')
  static const String shikimoriUrl = _Env.shikimoriUrl;

  @EnviedField(varName: 'HOST')
  static const String host = _Env.host;

  @EnviedField(varName: 'HOSTV2')
  static const String hostV2 = _Env.hostV2;

  @EnviedField(varName: 'UPDATE_HOST')
  static const String updateHost = _Env.updateHost;

  @EnviedField(varName: 'GRANT_TYPE')
  static const String grantType = _Env.grantType;

  @EnviedField(varName: 'REDIRECT_URL')
  static const String redirectUri = _Env.redirectUri;

  @EnviedField(varName: 'AUTHORIZATION_ENDPOINT')
  static const String authorizationEndpoint = _Env.authorizationEndpoint;

  @EnviedField(varName: 'TOKEN_ENDPOINT')
  static const String tokenEndpoint = _Env.tokenEndpoint;

  @EnviedField(
    varName: 'IDENTIFIER',
    obfuscate: true,
  )
  static final String identifier = _Env.identifier;

  @EnviedField(
    varName: 'SECRET',
    obfuscate: true,
  )
  static final String secret = _Env.secret;
}
