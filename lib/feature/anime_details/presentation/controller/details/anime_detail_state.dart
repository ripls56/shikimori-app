part of 'anime_detail_cubit.dart';

///Anime detail state
sealed class AnimeDetailState {
  ///Initial state
  const AnimeDetailState();

  ///Loaded state
  factory AnimeDetailState.loaded({
    required List<AnimeDetailsRelated> related,
    required AnimeDetails animeDetails,
    required List<AnimeDetailsRoles> roles,
    required PaletteGenerator palette,
  }) = AnimeDetailLoaded;

  ///Error state
  factory AnimeDetailState.error({
    required String errorMessage,
  }) = AnimeDetailError;

  ///Empty state
  factory AnimeDetailState.empty() = AnimeDetailEmpty;
}

///Anime detail loaded state
class AnimeDetailLoaded extends AnimeDetailState {
  ///Constructor
  AnimeDetailLoaded({
    required this.related,
    required this.animeDetails,
    required this.roles,
    required this.palette,
  });

  ///Anime details
  final AnimeDetails animeDetails;

  ///Related animes
  final List<AnimeDetailsRelated> related;

  ///Roles
  final List<AnimeDetailsRoles> roles;

  ///Palette from image
  final PaletteGenerator palette;
}

///Anime detail error state
class AnimeDetailError extends AnimeDetailState {
  ///Constructor
  AnimeDetailError({required this.errorMessage});

  ///Error message
  final String errorMessage;
}

///Anime detail empty state
class AnimeDetailEmpty extends AnimeDetailState {}
