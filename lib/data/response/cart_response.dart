import 'package:nike_store/data/cart_item.dart';

class CartResponse {
  final List<CartItemEntity> cartItems;
   int payblePrice;
   int totalPrice;
   int shippingCost;

  CartResponse(
      this.cartItems, this.payblePrice, this.totalPrice, this.shippingCost);
  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartItemEntity.parseJsonArray(json['cart_items']),
        payblePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingCost = json['shipping_cost'];
}
