class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowToHigh = 3;
}

class ProductEntity {
  final int id;
  final String title;
  final int price;
  final int discount;
  final String image;
  final int status;
  final int? previousPrice;

  ProductEntity(
    this.id,
    this.title,
    this.price,
    this.discount,
    this.image,
    this.status,
    this.previousPrice,
  );

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        discount = json['discount'],
        image = json['image'],
        status = json['status'],
        previousPrice = json['previous_price'];
}
