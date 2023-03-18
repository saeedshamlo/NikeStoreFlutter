

import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/data/product.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final String search;
  final List<ProductEntity> products;

  SearchSuccess(this.search, this.products);
}

class SearchError extends SearchState {
  final AppException exception;

  SearchError(this.exception);

  @override
  List<Object> get props => [exception];
}
