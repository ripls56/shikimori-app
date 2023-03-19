import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_page_state.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/anime/anime_loaded_widget.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/empty_widget.dart';

class AnimeScreenBuilder extends StatefulWidget {
  const AnimeScreenBuilder({super.key, required this.position});

  final double? position;
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
    context.read<AnimeCubit>().getAnimeList(animeListPage);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _setPosition() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(
        SCROLL_POSITION_KEY_NAME, _scrollController.position.pixels);
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      setState(() {
        animeListPage++;
        _setPosition();
      });
      context.read<AnimeCubit>().getAnimeList(animeListPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        animes.clear();
        context.read<AnimeCubit>().getAnimeList(1);
      },
      child: Stack(
        children: [
          BlocConsumer<AnimeCubit, AnimePageState>(
            listener: (context, state) {
              if (state is AnimePageLoading) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Загружается')));
              } else {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              }
            },
            builder: (context, state) {
              if (state is AnimePageError) {
                return Center(child: Text(state.errorMessage));
              }
              if (state is AnimePageLoaded || state is AnimePageLoading) {
                if (state is AnimePageLoaded) {
                  animes +=
                      context.select((AnimeCubit cubit) => state.animeList);
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
