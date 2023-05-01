import 'package:flutter/material.dart';

SnackBar loadingSnackBar(String title, BuildContext context) {
  final double height = MediaQuery.of(context).size.height * 0.023 < 20
      ? 20
      : MediaQuery.of(context).size.height * 0.023;
  return SnackBar(
    backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(.95),
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
              color: Theme.of(context).colorScheme.surface,
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
  );
}
