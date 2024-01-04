import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/routes.dart';
import 'package:url_launcher/url_launcher.dart';

///Parse html decryption and show it like basic widgets
class HtmlDescriptionWidget extends StatelessWidget {
  ///
  const HtmlDescriptionWidget({
    required this.data,
    super.key,
  });

  ///Description in html tags
  final String? data;

  Uri _characterDetailsPath(int id) => Uri(
        path: '${ScreenRoutes.home.path}${ScreenRoutes.characterDetails.path}',
        queryParameters: {
          'id': '$id',
        },
      );

  Uri _animeDetailPath(int id) => Uri(
        path: '${ScreenRoutes.home.path}${ScreenRoutes.animeDetails.path}',
        queryParameters: {
          'id': '$id',
        },
      );

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Html(
      style: {
        'div': Style(textAlign: TextAlign.justify),
        'a': Style(
          color: theme.colorScheme.primary,
          textDecoration: TextDecoration.none,
        ),
      },
      onLinkTap: (url, attributes, element) {
        if (attributes['data-attrs'] != null) {
          final data = jsonDecode(
            attributes['data-attrs'] ?? '',
          ) as Map<String, dynamic>;
          if (data['type'] == 'character') {
            debugPrint(data['id'].toString());
            context.pushReplacement(
              _characterDetailsPath(data['id'] as int).toString(),
            );
          }
          if (data['type'] == 'anime') {
            debugPrint(data['id'].toString());
            context.pushReplacement(
              _animeDetailPath(data['id'] as int).toString(),
            );
          }
          return;
        }
        if (attributes['href'] != null) {
          launchUrl(
            Uri.parse(attributes['href']!),
          );
        }
      },
      data: data,
    );
  }
}
