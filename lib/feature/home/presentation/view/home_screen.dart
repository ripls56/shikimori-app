import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/home_card_type.dart';
import 'package:shikimoriapp/core/helpers/screen_routes.dart';
import 'package:shikimoriapp/core/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/core/widgets/headline_button.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/home/presentation/controller/home/home_store.dart';
import 'package:shikimoriapp/feature/home/presentation/widgets/home_card.dart';
import 'package:shikimoriapp/feature/home/presentation/widgets/home_screen_drawer.dart';

import '../../../../core/widgets/custom_app_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final width = context.screenWidth;
    final theme = context.theme;
    return Scaffold(
      drawer: const HomeScreenDrawer(),
      appBar: const CustomAppBar(
        title: 'Главная',
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
                                  Uri(
                                    path:
                                        '/${ScreenRoutes.anime}/${ScreenRoutes.animeDetails}',
                                    queryParameters: {
                                      'id': '${anime.id}',
                                    },
                                  ).toString(),
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
                            label: Text('Попробовать еще раз'),
                            icon: Icon(Icons.update))
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
