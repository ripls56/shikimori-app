import 'package:flutter/material.dart';

///Custom snack bar service
abstract final class SnackBarService {
  ///Attach key in main.dart
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  ///Show loading snack bar
  static void loadingSnackBar(String title) {
    final size = MediaQuery.of(scaffoldKey.currentContext!).size;
    final height =
        (size.height * 0.023 < 20 ? 20 : size.height * 0.023).toDouble();
    scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(scaffoldKey.currentContext!)
            .colorScheme
            .secondary
            .withOpacity(.95),
        content: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              SizedBox(
                width: height,
                height: height,
                child: CircularProgressIndicator(
                  color:
                      Theme.of(scaffoldKey.currentContext!).colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        margin: const EdgeInsets.all(12),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
