import 'package:shikimori_app/feature/domain/entities/anime/anime.dart';

abstract class AnimePageState {}

class AnimePageLoadedState extends AnimePageState {
  final List<Anime> animeList;

  AnimePageLoadedState({required this.animeList});
}

class AnimePageEmptyState extends AnimePageState {}

class AnimePageErrorState extends AnimePageState {
  final String errorMessage;

  AnimePageErrorState({required this.errorMessage});
}
