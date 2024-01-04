import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/common/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/feature/authorization/presentation/controller/token/token_store.dart';
import 'package:shikimoriapp/routes.dart';

class TokenScreen extends StatefulWidget {
  const TokenScreen({
    super.key,
    required this.code,
  });

  final String code;

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  @override
  void initState() {
    super.initState();
    final store = context.read<TokenStore>();
    store.getAccessToken(widget.code);
    when(
      (p0) => store.userAuth != null,
      () {
        context.replace(
          ScreenRoutes.home.path,
          extra: store.userAuth,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomLoadingIndicator(),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Получаю токены',
                style: context.theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
