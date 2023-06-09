import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/view/home_screen.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/controller/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    context.read<LoginScreenCubit>().checkTokensExist().then((value) {
      if (value) {
        context.read<LoginScreenCubit>().login();
      } else {
        FlutterNativeSplash.remove();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenCubit, LoginScreenState>(
      listener: (context, state) {
        if (state is LoginScreenLoaded) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ), (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              AppImages.loagingPageBg,
              color: Colors.black,
            ),
            LoginButton(
              onTap: () {
                context.read<LoginScreenCubit>().login();
              },
            ),
          ],
        ),
      ),
    );
  }
}
