part of 'anime_detail_cubit.dart';

abstract class AnimeDetailState {}

class AnimeDetailLoaded extends AnimeDetailState {

  AnimeDetailLoaded({required this.related, required this.animeDetails});
  final AnimeDetails animeDetails;
  final List<Related> related;
}

class AnimeDetailError extends AnimeDetailState {

  AnimeDetailError({required this.errorMessage});
  final String errorMessage;
}

class AnimeDetailEmpty extends AnimeDetailState {}
