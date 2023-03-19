import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/domain/entities/anime/anime.dart';

abstract class AnimePageState extends Equatable {
  const AnimePageState();

  @override
  List<Object> get props => [];
}

class AnimePageLoaded extends AnimePageState {
  final List<Anime> animeList;

  const AnimePageLoaded({required this.animeList});
}

class AnimePageEmpty extends AnimePageState {}

class AnimePageLoading extends AnimePageState {}

class AnimePageError extends AnimePageState {
  final String errorMessage;

  const AnimePageError({required this.errorMessage});
}
