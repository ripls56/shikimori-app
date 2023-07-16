part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchAnimeEvent extends SearchEvent {

  const SearchAnimeEvent(this.query);
  final String query;
}
