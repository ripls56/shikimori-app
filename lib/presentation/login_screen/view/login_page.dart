import 'package:flutter/material.dart';
import 'package:shikimori_app/core/helpers/images.dart';
import 'package:shikimori_app/presentation/login_screen/widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AppImages.loagingPageBg,
            color: Colors.black,
          ),
          LoginButton(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
