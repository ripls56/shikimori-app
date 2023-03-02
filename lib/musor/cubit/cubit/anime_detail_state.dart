part of 'anime_detail_cubit.dart';

abstract class AnimeDetailState {}

class AnimeDetailInitial extends AnimeDetailState {
  final AnimeDetailsModel animeDetails;

  AnimeDetailInitial(this.animeDetails);
}

class AnimeDetailEmpty extends AnimeDetailState {}
