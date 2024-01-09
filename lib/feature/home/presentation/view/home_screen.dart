import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/widgets/custom_app_bar.dart';
import 'package:shikimoriapp/common/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/common/widgets/headline_header_delegate.dart';
import 'package:shikimoriapp/common/widgets/list_animation_configuration.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/home_card_type.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home/home_store.dart';
import 'package:shikimoriapp/feature/home/presentation/view/home_screen_drawer.dart';
import 'package:shikimoriapp/feature/home/presentation/widgets/home_card.dart';
import 'package:shikimoriapp/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeStore>().fetch();
  }

  String animeUrl(int id) => Uri(
        path: '${ScreenRoutes.home.path}${ScreenRoutes.animeDetails.path}',
        queryParameters: {
          'id': '$id',
        },
      ).toString();

  final updatePath =
      Uri(path: '${ScreenRoutes.home.path}${ScreenRoutes.update.path}')
          .toString();

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final width = context.screenWidth;
    final theme = context.theme;

    return Scaffold(
      drawer: HomeScreenDrawer(),
      drawerEdgeDragWidth: context.screenWidth * .1,
      appBar: CustomAppBar(
        title: 'Главная',
        actions: [
          IconButton(
            onPressed: () => context.go(updatePath),
            icon: const Badge(
              smallSize: 8,
              largeSize: 8,
              child: Icon(CupertinoIcons.arrow_down_doc_fill),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await context.read<HomeStore>().fetch();
          },
          child: Observer(
            builder: (context) {
              final animes = context.read<HomeStore>().animes;
              switch (context.read<HomeStore>().fetchFuture.status) {
                case FutureStatus.pending:
                  return SizedBox(
                    height: height - kToolbarHeight,
                    child: const Center(
                      child: CustomLoadingIndicator(),
                    ),
                  );
                case FutureStatus.fulfilled:
                  return CustomScrollView(
                    slivers: [
                      SliverMainAxisGroup(
                        slivers: [
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: HeadlineHeaderDelegate(
                              title: 'Сейчас на экранах',
                              onTap: () {},
                              minimalExtent: 50,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 10,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: height * 0.35,
                              width: width,
                              child: AnimationLimiter(
                                child: ListView.separated(
                                  primary: true,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: animes.length,
                                  itemBuilder: (context, index) {
                                    final anime = animes[index];
                                    final url = '${Env.shikimoriUrl}'
                                        '${anime.image?.original}';
                                    return ListAnimationConfiguration
                                        .horizontal(
                                      index: index,
                                      child: HomeCard(
                                        url: url,
                                        cardType: HomeCardType.anime,
                                        title: anime.russian ?? anime.name,
                                        onTap: () => context.go(
                                          animeUrl(anime.id),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 1000,
                        ),
                      ),
                    ],
                  );
                case FutureStatus.rejected:
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Что-то пошло не так ≡(▔﹏▔)≡',
                          style: theme.textTheme.bodyLarge,
                        ),
                        ElevatedButton.icon(
                          onPressed: () => context.read<HomeStore>().fetch(),
                          label: const Text('Попробовать еще раз'),
                          icon: const Icon(Icons.update),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
