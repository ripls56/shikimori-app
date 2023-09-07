import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/widgets/custom_app_bar.dart';
import 'package:shikimoriapp/common/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/common/widgets/headline_button.dart';
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

  Uri animeUrl(int id) => Uri(
        path: '/${ScreenRoutes.animeDetails}', //${ScreenRoutes.anime}
        queryParameters: {
          'id': '$id',
        },
      );

  final updatePath = Uri(path: '/${ScreenRoutes.update}');

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final width = context.screenWidth;
    final theme = context.theme;

    return Scaffold(
      drawer: HomeScreenDrawer(),
      appBar: CustomAppBar(
        title: 'Главная',
        actions: [
          IconButton(
            onPressed: () => context.go(updatePath.toString()),
            icon: const Badge(
              smallSize: 8,
              largeSize: 8,
              child: Icon(Icons.system_update_alt),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
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
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        HeadlineButton(
                          title: 'Сейчас на экранах',
                          onPress: () {},
                        ),
                        SizedBox(
                          height: height * 0.35,
                          width: width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: animes.length,
                            itemBuilder: (context, index) {
                              final anime = animes[index];
                              final url =
                                  '${Env.shikimoriUrl}${anime.image?.original}';
                              return HomeCard(
                                url: url,
                                cardType: HomeCardType.anime,
                                title: anime.russian ?? anime.name,
                                onTap: () => context.go(
                                  animeUrl(anime.id).toString(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 1600,
                        ),
                      ],
                    ),
                  );
                case FutureStatus.rejected:
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'Что-то пошло не так ≡(▔﹏▔)≡',
                          style: theme.textTheme.bodyLarge,
                        ),
                        ElevatedButton.icon(
                            onPressed: () => context.read<HomeStore>().fetch(),
                            label: const Text('Попробовать еще раз'),
                            icon: const Icon(Icons.update))
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
