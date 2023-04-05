import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shikimoriapp/core/widgets/anime_card.dart';
import 'package:shikimoriapp/feature/presentation/search/controller/search_cubit.dart';
import 'package:shikimoriapp/feature/presentation/widgets/custom_loading_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              floating: true,
              centerTitle: true,
              titleSpacing: 8,
              title: SearchAppBar(controller: controller),
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoaded) {
                    var animes = state.animes;
                    return Column(
                      children: [
                        //Anime builder
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                                    imageUrl:
                                        animes[index].image?.preview ?? '',
                                    title: animes[index].name,
                                    score: animes[index].score ?? '',
                                    episodes: animes[index].episodes ?? 1,
                                    animeId: animes[index].id,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        //Manga builder
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.mangas.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.green.shade200,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is SearchError) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  if (state is SearchLoading) {
                    return const CustomLoadingBar();
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required TextEditingController controller,
    String? order,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.3),
              spreadRadius: 1,
              blurRadius: 6),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(
            Icons.search,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                context.read<SearchCubit>().searchAnimeAndManga(value);
              },
              controller: _controller,
              decoration: InputDecoration(
                suffixIconConstraints: BoxConstraints.tight(const Size(24, 24)),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
                isCollapsed: true,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Поиск',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
