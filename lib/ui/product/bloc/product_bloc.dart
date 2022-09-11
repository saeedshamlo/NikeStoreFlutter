import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/data/repo/commnet_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;
  final IProductRepository productRepository;
  ProductBloc(this.cartRepository, this.productRepository)
      : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddButtonClick) {
        try {
          emit(ProductAddToCartButtonLoading());
          // await Future.delayed(Duration(seconds: 2));
          final result = await cartRepository.add(event.productId);
          await cartRepository.count();
          emit(ProductAddToCartSuccess());
        } catch (e) {
          if (e is DioError) {
            emit(ProductAddToCartError(
                AppException(message: e.response?.data['message'])));
          }
        }
      } else if (event is CommentAddButtonClick) {
        emit(CommnetAddLoading());
        try {
          final addComment = await productRepository.addCommnet(
              productId: event.productId,
              content: event.content,
              title: event.title);
          emit(CommnetAddSuccess());
        } catch (e) {
          emit(CommnetAddError(e is DioError
              ? AppException(message: e.response?.data['message'])
              : AppException()));
        }
      }
    });
  }
}
