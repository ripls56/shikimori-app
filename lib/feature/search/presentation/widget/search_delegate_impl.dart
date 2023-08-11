import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/core/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/view/anime_details.dart';
import 'package:shikimoriapp/feature/search/presentation/bloc/search_bloc.dart';

class SearchDelegateImpl extends SearchDelegate {
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
    return _SearchBuilder(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _SearchBuilder(query: query);
  }
}

class _SearchBuilder extends StatelessWidget {
  const _SearchBuilder({
    required this.query,
  });

  final String query;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;
    context.read<SearchBloc>().add(SearchAnimeEvent(query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.animes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AnimeDetailScreen(id: state.animes[index].id),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(.22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          height: height * 0.09,
                          imageUrl:
                              '${Env.shikimoriUrl}${state.animes[index].image?.x48}',
                        ),
                        Expanded(
                          child: Transform.translate(
                            offset: const Offset(0, 5),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                state.animes[index].name,
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
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
        return const Center(
          child: CustomLoadingIndicator(),
        );
      },
    );
  }
}
