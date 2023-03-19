// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/home/profile_cubit.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/anime/anime_screen_builder.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/home/home_nav_drawer.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/widgets/manga/manga_builder_widget.dart';

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
          AnimeScreenBuilder(
            position: _position,
          ),
          const MangaScreenBuilder(),
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
