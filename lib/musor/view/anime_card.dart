// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:shikimori_app/musor/view/anime_details.dart';

class AnimeCardWidget extends StatelessWidget {
  const AnimeCardWidget(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.score,
      required this.animeId})
      : super(key: key);

  final String imageUrl;
  final String title;
  final String score;
  final int animeId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(.05),
              blurRadius: 8,
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Material(
            child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnimeDetailScreen(id: animeId)));
              },
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: '${ApiClient.shikimoriUrl}$imageUrl',
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextTheme().headlineLarge,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        Text(score),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
