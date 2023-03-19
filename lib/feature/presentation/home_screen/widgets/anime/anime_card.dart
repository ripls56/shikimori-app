// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/anime_details.dart';

class AnimeCardWidget extends StatelessWidget {
  const AnimeCardWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.score,
    required this.episodes,
    required this.animeId,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String score;
  final int episodes;
  final int animeId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                color: Colors.black.withOpacity(.2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: '$SHIKIMORI_URL$imageUrl',
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: double.parse(score) / 2,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.blue.shade300,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(score),
                                ],
                              ),
                              Text('Эпизоды: $episodes'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnimeDetailScreen(id: animeId)));
              },
            ),
          )
        ],
      ),
    );
  }
}
