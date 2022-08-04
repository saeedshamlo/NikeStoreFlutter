part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartResponse cartResponse;

  CartSuccess(this.cartResponse);

  @override
  List<Object> get props => [cartResponse];
}

class CartError extends CartState {
  final AppException appException;

  CartError(this.appException);

  @override
  // TODO: implement props
  List<Object> get props => [appException];

}
