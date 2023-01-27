import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/cubit/home_cubit_cubit.dart';
import 'package:shikimori_app/cubit/profile_cubit.dart';
import 'package:shikimori_app/view/anime_card.dart';
import '../cubit/home_cubit_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getAnimes(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var animes = context.select((HomeCubit cubit) => cubit.state.animeList);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            body: animes.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shrinkWrap: true,
                    itemCount: animes.length,
                    itemBuilder: ((context, index) {
                      return AnimeCardWidget(
                        imageUrl: animes[index].image.original,
                        title: animes[index].name,
                        score: animes[index].score,
                        animeId: animes[index].id,
                      );
                    }),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            appBar: AppBar(),
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
                  Material(
                    child: InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text("Аниме"),
                      ),
                    ),
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text("Манга"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
