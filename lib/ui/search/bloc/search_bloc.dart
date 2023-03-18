import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/product_search.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/ui/search/bloc/search_state.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IProductRepository productRepository;
  SearchBloc(this.productRepository) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchListStarted) {
        emit(SearchLoading());
        try {
          final products = await productRepository.searchProduct(event.search);
          emit(SearchSuccess(event.search, products));
        } catch (e) {
          emit(SearchError(e is DioError
              ? AppException(message: e.response?.data['message'])
              : AppException()));
        }
      }
    });
  }
}
