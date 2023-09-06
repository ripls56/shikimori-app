import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:shikimoriapp/common/widgets/custom_text_button.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/creditional/creditional_store.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/login/login_screen_cubit.dart';
import 'package:shikimoriapp/feature/authorization/presentation/widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> animations = [
    'Left',
    'CenterLine',
    'Right',
    'RightCenter',
    'LeftCenterLine',
  ];

  final double blur = 2;

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
          context.read<CreditionalStore>().fetchCreditional();
          context.replace(
            Uri(
              path: '/',
            ).toString(),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.55),
                ),
                child: RiveAnimation.asset(
                  AppAssets.animeCollageAnimation,
                  fit: BoxFit.fill,
                  animations: animations,
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blur,
                  sigmaY: blur,
                ),
                child: const SizedBox.shrink(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  AppAssets.loginPageBg,
                  color: Colors.white,
                  width: 280,
                ),
                const Spacer(),
                LoginButton(
                  onTap: () {
                    context.read<LoginScreenCubit>().login();
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextButton(
                  text: 'Гость',
                  onTap: () {},
                  color: Colors.black.withOpacity(.75),
                ),
                const SizedBox(
                  height: 96,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
