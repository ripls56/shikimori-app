import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    StreamSubscription _sub;

    Future<void> initUniLinks() async {
      // ... check initialLink
      print('D/my statred');
      // Attach a listener to the stream
      _sub = linkStream.listen((link) {
        print('D/my work');
        print('D/my $link');
      });
      // NOTE: Don't forget to call _sub.cancel() in dispose
    }

    initUniLinks();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }

  final Uri _url = Uri.parse(
      'https://shikimori.one/oauth/authorize?client_id=bce7ad35b631293ff006be882496b29171792c8839b5094115268da7a97ca34c&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=user_rates');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final redirectUri = Uri.parse('urn:ietf:wg:oauth:2.0:oob');

    final authorizationEndpoint =
        Uri.parse('https://shikimori.one/oauth/authorize');
    final tokenEndpoint = Uri.parse('https://shikimori.one/oauth/authorize/');

    const identifier =
        'bce7ad35b631293ff006be882496b29171792c8839b5094115268da7a97ca34c';
    const secret =
        '811459eada36b14ff0cf0cc353f8162e72a7d6e6c7930b647a5c587d1beffe68';

    String code = "";

    var grant = oauth2.AuthorizationCodeGrant(
        identifier, authorizationEndpoint, tokenEndpoint,
        secret: secret);
    var authorizationUrl =
        grant.getAuthorizationUrl(redirectUri, scopes: ['user_rates']);
    var a = authorizationUrl.queryParameters;

    Future<void> getAccessToken() async {
      Dio _dio = Dio();
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
      var response = await _dio
          .post('https://shikimori.one/oauth/token', queryParameters: {
        'grant_type': 'authorization_code',
        'client_id': identifier,
        'client_secret': secret,
        'code': code,
        'redirect_uri': redirectUri.toString()
      });
      await _dio.get('https://shikimori.one/api/users/whoami');
    }

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            if (url.startsWith(tokenEndpoint.toString())) {
              getAccessToken();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) =>
                      Scaffold(body: Center(child: Text('work'))))));
              code = url.split('/')[5];
              print(code);
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains(tokenEndpoint.toString())) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(authorizationUrl);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Container(),
          onPressed: () {},
        ),
        body: Center(child: WebViewWidget(controller: controller)),
      ),
    );
  }
}
