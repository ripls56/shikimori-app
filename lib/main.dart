import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home());
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiClient apiClient = ApiClient();
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
            if (url.startsWith(apiClient.tokenEndpoint.toString())) {
              if (apiClient.code != "") apiClient.getCreditionals();
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: ((context) => Scaffold(
              //           floatingActionButton: FloatingActionButton(
              //               onPressed: () => apiClient.getRateList()),
              //           body: Center(
              //             child: Text('work'),
              //           ),
              //         )),
              //   ),
              // ); // home window
              apiClient.code = url.split('/')[5];
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains(apiClient.tokenEndpoint.toString())) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(apiClient.authorizationUrl);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Container(),
          onPressed: () {
            apiClient.addAnimeInRateList();
          },
        ),
        body: Center(child: WebViewWidget(controller: controller)),
      ),
    );
  }
}
