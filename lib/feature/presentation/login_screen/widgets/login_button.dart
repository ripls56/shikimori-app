import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function() onTap;
  const LoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2))],
              ),
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: size.width / 3),
              child: GestureDetector(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            child: Text(
              'Войти',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
