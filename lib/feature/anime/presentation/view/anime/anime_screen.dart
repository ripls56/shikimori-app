import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/helpers/snack_bar_service.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime/presentation/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/anime/presentation/controller/anime/anime_page_state.dart';
import 'package:shikimoriapp/feature/anime/presentation/view/anime/anime_loaded_widget.dart';
import 'package:shikimoriapp/feature/home/presentation/widgets/empty_widget.dart';

///Anime screen
class AnimeScreen extends StatefulWidget {
  ///Constructor
  const AnimeScreen({
    this.order,
    super.key,
    this.season,
    this.limit,
    this.score,
    this.status,
  });

  final String? order;
  final String? season;
  final int? score;
  final String? status;
  final int? limit;
  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  double? scrollPosition;
  late ScrollController _scrollController;
  List<Anime> animes = [];
  int animeListPage = 1;

  @override
  void initState() {
    _scrollController = ScrollController();
    context.read<AnimePageCubit>().getAnimeList(
          animeListPage,
          order: widget.order,
          status: widget.status,
          season: widget.season,
          limit: widget.limit,
          score: widget.score,
        );
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      setState(() {
        animeListPage++;
      });
      context.read<AnimePageCubit>().getAnimeList(
            animeListPage,
            order: widget.order,
            status: widget.status,
            season: widget.season,
            limit: widget.limit,
            score: widget.score,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        animes.clear();
        await context.read<AnimePageCubit>().getAnimeList(
              animeListPage,
              order: widget.order,
              status: widget.status,
              season: widget.season,
              limit: widget.limit,
              score: widget.score,
            );
      },
      child: Stack(
        children: [
          BlocConsumer<AnimePageCubit, AnimePageState>(
            listener: (context, state) {
              if (state is AnimePageLoading) {
                SnackBarService.loadingSnackBar('Загрузка');
              } else if (state is AnimePageEmpty) {
                animes.clear();
              } else {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              }
            },
            builder: (context, state) {
              if (state is AnimePageError) {
                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<AnimePageCubit>().getAnimeList(
                            animeListPage,
                            order: widget.order,
                            status: widget.status,
                            season: widget.season,
                            limit: widget.limit,
                            score: widget.score,
                          ),
                  child: Center(child: Text(state.errorMessage)),
                );
              }
              if (state is AnimePageLoaded || state is AnimePageLoading) {
                if (state is AnimePageLoaded) {
                  animes +=
                      context.select((AnimePageCubit cubit) => state.animeList);
                }
                return AnimeLoadedWidget(
                  animes: animes,
                  controller: _scrollController,
                );
              }
              return const EmptyWidget();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () async {
                  await _scrollController.position.animateTo(
                    _scrollController.position.minScrollExtent,
                    curve: Curves.easeInCubic,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                  );
                },
                child: const Icon(Icons.arrow_upward),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
