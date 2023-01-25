import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:shikimori_app/cubit/home_cubit_cubit.dart';
import 'package:shikimori_app/view/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => HomeCubit()),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
          ),
          home: const Home()),
    );
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => Scaffold(
                        floatingActionButton:
                            FloatingActionButton(onPressed: () {}),
                        body: const HomeScreen(),
                      )),
                ),
              ); // home window
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
        body: Center(child: WebViewWidget(controller: controller)),
      ),
    );
  }
}
