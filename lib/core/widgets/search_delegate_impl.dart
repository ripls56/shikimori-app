import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/helpers/helper.dart';
import 'package:shikimoriapp/core/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/view/anime_details.dart';
import 'package:shikimoriapp/feature/presentation/search/controller/search_cubit.dart';

class SearchDelegateImpl extends SearchDelegate {
  CancelableOperation? cancelableOperation;
  CancelableCompleter completer = CancelableCompleter(
    onCancel: () => debugPrint('search cancel'),
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    cancelableOperation?.cancel();
    start(context);
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoaded) {
          return ListView.builder(
            itemCount: state.animes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      HapticFeedback.lightImpact();
                      return AnimeDetailScreen(id: state.animes[index].id);
                    },
                  ),
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                        imageUrl:
                            '$SHIKIMORI_URL${state.animes[index].image?.x96}')
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: CustomLoadingBar(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    completer.complete(Future.value(
        () => context.read<SearchCubit>().searchAnimeAndManga(query)));
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoaded) {
          return ListView.builder(
            itemCount: state.animes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        HapticFeedback.lightImpact();
                        return AnimeDetailScreen(id: state.animes[index].id);
                      },
                    ),
                  ),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                          imageUrl:
                              '$SHIKIMORI_URL${state.animes[index].image?.x48}'),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          state.animes[index].name,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CustomLoadingBar(),
        );
      },
    );
  }

  void start(BuildContext context) {}
}
