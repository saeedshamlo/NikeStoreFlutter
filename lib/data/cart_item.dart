import 'package:flutter/cupertino.dart';
import 'package:nike_store/data/product.dart';

class CartItemEntity {
  final ProductEntity product;
  final int id;
   int count;
  bool deleteButtonLoading = false;
  bool changeCountLoading =false;

  CartItemEntity(this.product, this.id, this.count);

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json["product"]),
        id = json['cart_item_id'],
        count = json['count'];

  static List<CartItemEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItemEntity> result = [];
    jsonArray.forEach((element) {
      result.add(CartItemEntity.fromJson(element));
    });
    return result;
  }
}
