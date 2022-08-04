class AddToCartResponse {
  final int productId;
  final int cartItemId;
  final int count;
  final String? message;

  AddToCartResponse(this.productId, this.cartItemId, this.count, this.message);

  AddToCartResponse.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        cartItemId = json['id'],
        count = json['count'],
        message = json['message'];
}
