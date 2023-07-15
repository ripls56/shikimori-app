// import 'package:flutter/material.dart';
// import 'package:shikimoriapp/feature/domain/entities/manga/character_manga.dart';
// import 'package:shikimoriapp/feature/presentation/home_screen/controller/manga/manga_cubit.dart';

// class MangaScreenBuilder extends StatefulWidget {
//   const MangaScreenBuilder({Key? key}) : super(key: key);

//   @override
//   State<MangaScreenBuilder> createState() => _MangaScreenBuilderState();
// }

// class _MangaScreenBuilderState extends State<MangaScreenBuilder> {
//   List<Manga> mangas = [];

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         mangas.clear();
//         context.read<MangaCubit>().getAnimeList(1);
//       },
//       child: Stack(
//         children: [
//           BlocConsumer<AnimeCubit, AnimePageState>(
//             listener: (context, state) {
//               if (state is AnimePageLoading) {
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(const SnackBar(content: Text('Загружается')));
//               } else {
//                 ScaffoldMessenger.of(context).removeCurrentSnackBar();
//               }
//             },
//             builder: (context, state) {
//               if (state is AnimePageError) {
//                 return RefreshIndicator(
//                     onRefresh: () async => context.read<AnimeCubit>().getAnimes,
//                     child: Center(child: Text(state.errorMessage)));
//               }
//               if (state is AnimePageLoaded || state is AnimePageLoading) {
//                 if (state is AnimePageLoaded) {
//                   animes +=
//                       context.select((AnimeCubit cubit) => state.animeList);
//                 }
//                 return AnimeLoadedWidget(
//                   animes: animes,
//                   controller: _scrollController,
//                 );
//               }
//               return const EmptyWidget();
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(18),
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: FloatingActionButton(
//                 onPressed: () async {
//                   await Future.delayed(const Duration(milliseconds: 200));
//                   _scrollController.position
//                       .jumpTo(_scrollController.position.minScrollExtent);
//                 },
//                 child: const Icon(Icons.arrow_upward),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
