import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime/presentation/controller/anime/anime_page_cubit.dart';

///State for [AnimePageCubit]
abstract class AnimePageState extends Equatable {
  ///Constructor
  const AnimePageState();

  @override
  List<Object> get props => [];
}

///State for [AnimePageCubit]
class AnimePageLoaded extends AnimePageState {
  ///Constructor
  const AnimePageLoaded({required this.animeList});

  ///List of [Anime]
  final List<Anime> animeList;
}

///State for [AnimePageCubit]
class AnimePageEmpty extends AnimePageState {}

///State for [AnimePageCubit]
class AnimePageLoading extends AnimePageState {}

///State for [AnimePageCubit]
class AnimePageError extends AnimePageState {
  ///Constructor
  const AnimePageError({required this.errorMessage});

  ///Error message
  final String errorMessage;
}
