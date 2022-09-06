part of 'cart_bloc.dart';

abstract class CartState  {
  const CartState();


}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartResponse cartResponse;

  CartSuccess(this.cartResponse);

 
}

class CartError extends CartState {
  final AppException appException;

  CartError(this.appException);



}
class CartChangeError extends CartState {
  final AppException appException;
  CartChangeError(this.appException);
}

class CartAuthRequired extends CartState{}

class CartEmpty extends CartState{

}