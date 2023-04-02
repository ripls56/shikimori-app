part of 'manga_cubit.dart';

abstract class MangaPageState extends Equatable {
  const MangaPageState();

  @override
  List<Object> get props => [];
}

class MangaPageEmpty extends MangaPageState {}

class MangaPageError extends MangaPageState {
  final String errorMessage;

  const MangaPageError({required this.errorMessage});
}

class MangaPageLoaded extends MangaPageState {
  final List<Manga> mangaList;

  const MangaPageLoaded({required this.mangaList});
}

class MangaPageLoading extends MangaPageState {}
