part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {

  const SearchLoaded({required this.animes});
  final List<Anime> animes;
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {

  const SearchError({required this.errorMessage});
  final String errorMessage;
}
