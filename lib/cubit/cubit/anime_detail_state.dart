part of 'anime_detail_cubit.dart';

@immutable
abstract class AnimeDetailState {}

class AnimeDetailInitial extends AnimeDetailState {
  final AnimeDetails animeDetails;

  AnimeDetailInitial(this.animeDetails);
}

class AnimeDetailEmpty extends AnimeDetailState {}
