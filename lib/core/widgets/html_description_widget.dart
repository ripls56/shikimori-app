import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/anime_details.dart';
import 'package:shikimoriapp/feature/presentation/character_screen/view/character_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlDescriptionWidget extends StatelessWidget {
  const HtmlDescriptionWidget({
    super.key,
    required this.data,
  });

  final String? data;

  @override
  Widget build(BuildContext context) {
    return Html(
      style: {
        'div': Style(textAlign: TextAlign.justify),
      },
      onLinkTap: (url, attributes, element) {
        if (attributes['data-attrs'] != null) {
          Map<String, dynamic> data = jsonDecode(attributes['data-attrs']!);

          if (data['type'] == 'character') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CharacterScreen(id: data['id']),
              ),
            );
          }
          if (data['type'] == 'anime') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AnimeDetailScreen(id: data['id']),
              ),
            );
          }
          return;
        }
        if (attributes['href'] != null) {
          launchUrl(Uri.parse(attributes['href']!),
              mode: LaunchMode.externalApplication);
        }
      },
      data: data,
    );
  }
}
