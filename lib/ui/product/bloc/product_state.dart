part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductAddToCartButtonLoading extends ProductState {}

class ProductAddToCartError extends ProductState {
  final AppException exception;

  ProductAddToCartError(this.exception);
  @override
  List<Object> get props => [exception];
}

class ProductAddToCartSuccess extends ProductState {}


class CommnetAddSuccess extends ProductState{}
class CommnetAddLoading extends ProductState{}
class CommnetAddError extends ProductState{
   final AppException exception;

  CommnetAddError(this.exception);
  @override
  List<Object> get props => [exception];
}
