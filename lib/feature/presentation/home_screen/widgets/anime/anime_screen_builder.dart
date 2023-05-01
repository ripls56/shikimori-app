import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/widgets/custom_snack_bar.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_page_state.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/anime/anime_loaded_widget.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/empty_widget.dart';

class AnimeScreenBuilder extends StatefulWidget {
  const AnimeScreenBuilder(
      {super.key, required this.position, required this.order});

  final double? position;
  final String order;
  @override
  State<AnimeScreenBuilder> createState() => _AnimeScreenBuilderState();
}

class _AnimeScreenBuilderState extends State<AnimeScreenBuilder> {
  double? scrollPosition;
  late ScrollController _scrollController;
  List<Anime> animes = [];
  int animeListPage = 1;

  @override
  void initState() {
    _scrollController = ScrollController();
    context
        .read<AnimePageCubit>()
        .getAnimeList(animeListPage, order: widget.order);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      setState(() {
        animeListPage++;
      });
      context.read<AnimePageCubit>().getAnimeList(animeListPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        animes.clear();
        context.read<AnimePageCubit>().getAnimeList(1);
      },
      child: Stack(
        children: [
          BlocConsumer<AnimePageCubit, AnimePageState>(
            listener: (context, state) {
              if (state is AnimePageLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  loadingSnackBar('Занружается', context),
                );
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
                        context.read<AnimePageCubit>().getAnimeList(1),
                    child: Center(child: Text(state.errorMessage)));
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
                  await Future.delayed(const Duration(milliseconds: 200));
                  _scrollController.position
                      .jumpTo(_scrollController.position.minScrollExtent);
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
