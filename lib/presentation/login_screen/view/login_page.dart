import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shikimori_app/core/helpers/images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AppImages.loagingPageBg,
            color: Colors.white,
          ),
          const LoginButton(),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: () {},
      child: const Text(
        'Войти',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
