part of 'anime_detail_cubit.dart';

abstract class AnimeDetailState {}

class AnimeDetailLoaded extends AnimeDetailState {
  final AnimeDetails animeDetails;

  AnimeDetailLoaded({required this.animeDetails});
}

class AnimeDetailEmpty extends AnimeDetailState {}
