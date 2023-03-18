part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchListStarted extends SearchEvent {
  final String search;

  SearchListStarted(this.search);
}
