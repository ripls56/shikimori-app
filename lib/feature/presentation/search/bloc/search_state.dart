part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final List<Anime> animes;

  const SearchLoaded({required this.animes});
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String errorMessage;

  const SearchError({required this.errorMessage});
}
