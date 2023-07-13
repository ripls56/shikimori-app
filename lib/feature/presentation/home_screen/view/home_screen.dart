import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/widgets/search_delegate_impl.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/anime/anime_page_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/anime/anime_screen_builder.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/home/home_nav_drawer.dart';

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
        title: Text(drawerItems[_page]['name']),
      ),
      drawer: HomeNavDrawer(
          drawerItems: drawerItems, page: _page, controller: _pageController),
    );
  }

  void filterModalBotomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                        BlocProvider.of<AnimePageCubit>(context)
                            .getAnimeList(1, order: orderVariants[index ?? 0]);
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
      }),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    selectedRadioTile = 0;
    _pageController = PageController(initialPage: 0);
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
