import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/constants.dart';

import '../cubit/cubit/anime_detail_cubit.dart';

class AnimeDetailScreen extends StatefulWidget {
  const AnimeDetailScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  @override
  void initState() {
    context.read<AnimeDetailCubit>().getAnimeById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnimeDetailCubit, AnimeDetailState>(
        builder: (context, state) {
          if (state is AnimeDetailInitial) {
            var animeDetails = state.animeDetails;
            return Scaffold(
              body: ListView(
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width / 2,
                          imageUrl:
                              '$SHIKIMORI_URL${animeDetails.image.original}'),
                    ],
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
