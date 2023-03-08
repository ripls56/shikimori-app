// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_page_state.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/home/profile_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/anime_card.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/loading_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _page = 0;
  double? _position;

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
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        controller: _pageController,
        children: [
          _AnimeScreenBuilder(
            position: _position,
          ),
          const _MangaScreenBuilder(),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(drawerItems[_page]['name']),
      ),
      drawer: HomeNavDrawer(
          drawerItems: drawerItems, page: _page, controller: _pageController),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    _getScrollPosition();
    _pageController = PageController(initialPage: 0);
    context.read<ProfileCubit>().getCreditionals();
    super.initState();
  }

  void _getScrollPosition() async {
    var prefs = await SharedPreferences.getInstance();
    _position = prefs.getDouble(SCROLL_POSITION_KEY_NAME);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}

class HomeNavDrawer extends StatelessWidget {
  const HomeNavDrawer({
    super.key,
    required this.drawerItems,
    required int page,
    required PageController controller,
  })  : _page = page,
        _controller = controller;

  final List drawerItems;
  final int _page;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: BlocBuilder<ProfileCubit, ProfileState>(
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
    );
  }
}

class _MangaScreenBuilder extends StatelessWidget {
  const _MangaScreenBuilder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('manga'),
    );
  }
}

class _AnimeScreenBuilder extends StatefulWidget {
  const _AnimeScreenBuilder({required this.position});

  final double? position;
  @override
  State<_AnimeScreenBuilder> createState() => _AnimeScreenBuilderState();
}

class _AnimeScreenBuilderState extends State<_AnimeScreenBuilder> {
  double? scrollPosition;
  late ScrollController _scrollController;
  List<Anime> animes = [];
  int animeListPage = 1;

  @override
  void initState() {
    _scrollController =
        ScrollController(initialScrollOffset: widget.position ?? 0.0);
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
    return BlocBuilder<AnimeCubit, AnimePageState>(
      builder: (context, state) {
        if (state is AnimePageError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is AnimePageLoaded) {
          animes += context.select((AnimeCubit cubit) => state.animeList);
          return RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              animes.clear();
              context.read<AnimeCubit>().getAnimeList(1);
            },
            child: Stack(
              children: [
                _AnimeLoadedWidget(
                  animes: animes,
                  controller: _scrollController,
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () async {
                        await Future.delayed(const Duration(milliseconds: 200));
                        SchedulerBinding.instance.addPostFrameCallback(
                          (_) {
                            _scrollController.position.jumpTo(
                                _scrollController.position.minScrollExtent);
                          },
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
        if (state is AnimePageEmpty && animeListPage > 1) {
          return const _AnimeEmptyWidget();
        }
        return const _AnimeEmptyWidget();
      },
    );
  }
}

class _AnimeLoadedWidget extends StatelessWidget {
  const _AnimeLoadedWidget(
      {required this.animes, required ScrollController controller})
      : _controller = controller;
  final ScrollController _controller;
  final List<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey<String>(SCROLL_POSITION_KEY_NAME),
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      itemExtent: 200,
      itemCount: animes.length,
      itemBuilder: ((context, index) {
        return AnimationConfiguration.staggeredList(
          delay: Duration.zero,
          position: index,
          child: ScaleAnimation(
            duration: const Duration(milliseconds: 500),
            child: FadeInAnimation(
              duration: const Duration(milliseconds: 500),
              child: AnimeCardWidget(
                imageUrl: animes[index].image.preview,
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

class _AnimeEmptyWidget extends StatelessWidget {
  const _AnimeEmptyWidget();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      itemExtent: 200,
      itemCount: 15,
      itemBuilder: ((context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          child: const FadeInAnimation(
              duration: Duration(milliseconds: 500), child: LoadingCard()),
        );
      }),
    );
  }
}
