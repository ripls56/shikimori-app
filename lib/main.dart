import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'musor/cubit/cubit/anime_detail_cubit.dart';
import 'musor/cubit/home_cubit_cubit.dart';
import 'musor/cubit/profile_cubit.dart';

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
        BlocProvider<ProfileCubit>(
          create: ((context) => ProfileCubit()),
        ),
        BlocProvider<AnimeDetailCubit>(
          create: ((context) => AnimeDetailCubit()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder()
            }),
            colorSchemeSeed: Colors.blueAccent,
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          home: const Home()),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //late final WebViewController controller;
  @override
  Widget build(BuildContext context) {
    ApiClient apiClient = ApiClient();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileEmpty) {
          // controller = WebViewController()
          //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
          //   ..setBackgroundColor(const Color(0x00000000))
          //   ..setNavigationDelegate(
          //     NavigationDelegate(
          //       onPageFinished: (String url) async {
          //         if (url.startsWith(apiClient.tokenEndpoint.toString())) {
          //           if (apiClient.code != "") {
          //             context.read<ProfileCubit>().getCreditional();
          //           }
          //           Navigator.of(context).pushReplacement(
          //             MaterialPageRoute(
          //               builder: ((context) => const HomeScreen()),
          //             ),
          //           );
          //           apiClient.code = url.split('/')[5];
          //         }
          //       },
          //       onWebResourceError: (WebResourceError error) {},
          //       onNavigationRequest: (NavigationRequest request) async {
          //         if (request.url
          //             .contains(apiClient.tokenEndpoint.toString())) {
          //           return NavigationDecision.navigate;
          //         }
          //         return NavigationDecision.navigate;
          //       },
          //     ),
          //   )
          //   ..loadRequest(apiClient.authorizationUrl);
        }
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    context.read<ProfileCubit>().authorize(context)),
            body: Center(
              child: Text(''),
            ),
          ),
        );
      },
    );
  }
}
