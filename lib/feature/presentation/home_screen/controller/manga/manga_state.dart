part of 'manga_cubit.dart';

abstract class MangaPageState extends Equatable {
  const MangaPageState();

  @override
  List<Object> get props => [];
}

class MangaPageEmpty extends MangaPageState {}

class MangaPageError extends MangaPageState {

  const MangaPageError({required this.errorMessage});
  final String errorMessage;
}

class MangaPageLoaded extends MangaPageState {

  const MangaPageLoaded({required this.mangaList});
  final List<Manga> mangaList;
}

class MangaPageLoading extends MangaPageState {}
