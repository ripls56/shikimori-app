import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/presentation/login_screen/controller/login_screen_cubit.dart';
import 'package:shikimoriapp/presentation/login_screen/widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginScreenCubit, LoginScreenState>(
      builder: (context, state) {
        if (state is LoginScreenLoaded) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text(state.userAuthModel.accessToken)],
            ),
          );
        }
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
                onTap: () {
                  context.read<LoginScreenCubit>().login(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
