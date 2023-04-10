part of 'anime_detail_cubit.dart';

abstract class AnimeDetailState {}

class AnimeDetailLoaded extends AnimeDetailState {
  final AnimeDetails animeDetails;
  final List<Related> related;

  AnimeDetailLoaded({required this.related, required this.animeDetails});
}

class AnimeDetailError extends AnimeDetailState {
  final String errorMessage;

  AnimeDetailError({required this.errorMessage});
}

class AnimeDetailEmpty extends AnimeDetailState {}
