import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shikimori_app/feature/domain/entities/anime/anime.dart';
import 'package:shikimori_app/musor/cubit/profile_cubit.dart';
import 'package:shikimori_app/presentation/home_screen/controller/anime_cubit.dart';
import 'package:shikimori_app/presentation/home_screen/controller/anime_page_state.dart';
import 'package:shikimori_app/presentation/home_screen/widgets/anime_card.dart';
import 'package:shikimori_app/presentation/home_screen/widgets/loading_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _controller;
  int _page = 0;
  String title = "";

  List drawerItems = [
    {
      "icon": Icons.animation,
      "name": "Аниме",
    },
    {
      "icon": Icons.book,
      "name": "Манга",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        controller: _controller,
        children: const [
          _AnimeScreenBuilder(),
          _MangaScreenBuilder(),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileInitial) {
                  return CircleAvatar(
                    radius: 70,
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl: state.creditional.image.x160,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                Map item = drawerItems[index];
                return Column(
                  children: [
                    if (index == 0)
                      const Divider(
                        height: 2,
                      ),
                    ListTile(
                      leading: Icon(
                        item['icon'],
                        color: _page == index
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.titleMedium?.color,
                      ),
                      title: Text(
                        item['name'],
                        style: TextStyle(
                          color: _page == index
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).textTheme.titleMedium?.color,
                        ),
                      ),
                      onTap: () {
                        _controller.jumpToPage(index);
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(
                      height: 2,
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _controller.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
      title = drawerItems[page]['name'];
    });
  }
}

class _MangaScreenBuilder extends StatelessWidget {
  const _MangaScreenBuilder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('manga'),
    );
  }
}

class _AnimeScreenBuilder extends StatefulWidget {
  const _AnimeScreenBuilder({Key? key}) : super(key: key);

  @override
  State<_AnimeScreenBuilder> createState() => _AnimeScreenBuilderState();
}

class _AnimeScreenBuilderState extends State<_AnimeScreenBuilder> {
  @override
  void initState() {
    context.read<AnimeCubit>().getAnimeList(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeCubit, AnimePageState>(
      builder: (context, state) {
        if (state is AnimePageErrorState) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is AnimePageEmptyState) {
          return const _HomeEmptyWidget();
        }
        if (state is AnimePageLoadedState) {
          var animes = context.select((AnimeCubit cubit) => state.animeList);
          return _HomeLoadedWidget(animes: animes);
        }
        return const _HomeEmptyWidget();
      },
    );
  }
}

class _HomeLoadedWidget extends StatelessWidget {
  const _HomeLoadedWidget({
    required this.animes,
  });

  final List<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      itemExtent: 319,
      itemCount: animes.length,
      itemBuilder: ((context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 50),
          child: ScaleAnimation(
            duration: const Duration(milliseconds: 500),
            child: FadeInAnimation(
              duration: const Duration(milliseconds: 500),
              child: AnimeCardWidget(
                imageUrl: animes[index].image.original,
                title: animes[index].name,
                score: animes[index].score,
                episodes: animes[index].episodes,
                animeId: animes[index].id,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _HomeEmptyWidget extends StatelessWidget {
  const _HomeEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      itemExtent: 319,
      itemCount: 15,
      itemBuilder: ((context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 50),
          child: const ScaleAnimation(
            duration: Duration(milliseconds: 500),
            child: FadeInAnimation(
                duration: Duration(milliseconds: 500), child: LoadingCard()),
          ),
        );
      }),
    );
  }
}
