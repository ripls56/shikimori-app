import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:shikimoriapp/common/theme/app_colors.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/credential/credential_store.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/login/login_screen_cubit.dart';
import 'package:shikimoriapp/routes.dart';

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
    final theme = context.theme;
    return BlocListener<LoginScreenCubit, LoginScreenState>(
      listener: (context, state) {
        if (state is LoginScreenLoaded) {
          context.read<CredentialStore>().fetchCreditional();
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
                  color: Colors.black.withOpacity(.80),
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
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      AppAssets.loginPageBg,
                      color: AppColors.purple.shade50,
                      width: 280,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (Platform.isAndroid)
                          const SizedBox(
                            width: 66,
                          ),
                        OutlinedButton(
                          onPressed: () => context.replace(
                            ScreenRoutes.home.path,
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.purple.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: AppColors.purple.shade50,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            child: Text(
                              'Гость',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.purple.shade50,
                              ),
                            ),
                          ),
                        ),
                        if (Platform.isAndroid)
                          const SizedBox(
                            width: 14,
                          ),
                        if (Platform.isAndroid)
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.purple.shade50,
                            ),
                            onPressed: () =>
                                context.read<LoginScreenCubit>().login(),
                            icon: Padding(
                              padding: const EdgeInsets.all(6),
                              child: SvgPicture.asset(
                                AppAssets.shikimoriLogo,
                                height: 26,
                                width: 26,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 112,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
