part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState{}


class SearchError extends SearchState{
  final AppException exception;

  SearchError(this.exception);
  
  @override
  List<Object> get props => [exception];
}