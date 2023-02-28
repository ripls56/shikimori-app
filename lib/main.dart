import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:shikimori_app/constants.dart';
import 'package:shikimori_app/feature/data/datasources/user_auth/user_auth_remote_data_source_impl.dart';
import 'package:shikimori_app/feature/domain/repositories/user_auth_repository.dart';
import 'package:shikimori_app/presentation/login_screen/view/login_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'musor/cubit/cubit/anime_detail_cubit.dart';
import 'musor/cubit/home_cubit_cubit.dart';
import 'musor/cubit/profile_cubit.dart';
import 'musor/view/home_screen.dart';

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
          home: const LoginScreen()),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final apiClient = ApiClient();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          launchUrl(apiClient.authorizationUrl,
              mode: LaunchMode.platformDefault);
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextField(
              controller: controller,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final auth = UserAuthRemoteDataSourceImpl();
              },
              child: const Text('нажать'))
        ],
      ),
    );
  }
}
