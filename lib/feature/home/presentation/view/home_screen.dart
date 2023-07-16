import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/anime/presentation/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/anime/presentation/view/anime/anime_screen_builder.dart';
import 'package:shikimoriapp/feature/profile/presentation/profile_nav_drawer.dart';
import 'package:shikimoriapp/feature/search/presentation/widget/search_delegate_impl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  int _page = 0;

  double? _position;

  List<(IconData, String)> drawerItems = [
    (Icons.animation, 'Аниме'),
    (Icons.book, 'Манга'),
  ];

  late int selectedRadioTile;

  final orderVariants = [
    'popularity',
    'ranked',
    'name',
    'random',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        controller: _pageController,
        children: [
          AnimeScreenBuilder(
            position: _position,
            order: orderVariants[selectedRadioTile],
          ),
          // const MangaScreenBuilder(),
          Container(),
        ],
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              filterModalBotomSheet(context);
            },
            icon: const Icon(Icons.filter_alt),
          ),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchDelegateImpl());
            },
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text(drawerItems[_page].$2),
      ),
      drawer: ProfileNavDrawer(
        drawerItems: drawerItems,
        page: _page,
        controller: _pageController,
      ),
    );
  }

  void filterModalBotomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Сортировка:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Column(
                children: orderVariants
                    .map(
                      (order) => RadioListTile(
                        value: orderVariants
                            .indexWhere((element) => element == order),
                        groupValue: selectedRadioTile,
                        title: Text(order),
                        onChanged: (index) {
                          BlocProvider.of<AnimePageCubit>(context).getAnimeList(
                            1,
                            order: orderVariants[index ?? 0],
                          );
                          state(() {
                            selectedRadioTile = index ?? 0;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    selectedRadioTile = 0;
    _pageController = PageController();
    super.initState();
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
