part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}
class CartStarted extends CartEvent{
  final AuthInfo? authInfo;
  final bool isRefreshing;

  CartStarted(this.authInfo,{this.isRefreshing =false});
}

class CartDeleteButtonClicked extends CartEvent{
  final int cartItemId;

 const CartDeleteButtonClicked(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];

}

class CartIncCountButtonClicked extends CartEvent{
  final int cartItemId;

  CartIncCountButtonClicked(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class CartDecCountButtonClicked extends CartEvent{
  final int cartItemId;

  CartDecCountButtonClicked(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class CartAuthInfoChanged extends CartEvent{
  final AuthInfo? authInfo;

  CartAuthInfoChanged(this.authInfo);
}
