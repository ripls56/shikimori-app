import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LoginButton extends StatelessWidget {
  final Function() onTap;
  const LoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: size.width / 3),
      child: NeumorphicButton(
        onPressed: onTap,
        child: Center(
          child: Text(
            'Войти',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
