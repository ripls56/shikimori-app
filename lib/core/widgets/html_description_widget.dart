import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/anime_details.dart';
import 'package:shikimoriapp/feature/character/presentation/view/character_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Html(
      style: {
        'div': Style(textAlign: TextAlign.justify),
      },
      onLinkTap: (url, attributes, element) {
        if (attributes['data-attrs'] != null) {
          final data = jsonDecode(
            attributes['data-attrs'] ?? '',
          ) as Map<String, dynamic>;

          if (data['type'] == 'character') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CharacterScreen(id: data['id'] as int),
              ),
            );
          }
          if (data['type'] == 'anime') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AnimeDetailScreen(id: data['id'] as int),
              ),
            );
          }
          return;
        }
        if (attributes['href'] != null) {
          launchUrl(
            Uri.parse(attributes['href']!),
            mode: LaunchMode.externalApplication,
          );
        }
      },
      data: data,
    );
  }
}
