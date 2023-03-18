class ProductSearch {
  final int id;
  final String title;
  final int price;
  final int discount;
  final String image;
  final int status;
  final int views;

  ProductSearch(this.id, this.title, this.price, this.discount, this.image,
      this.status, this.views);

  ProductSearch.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        discount = json['discount'],
        image = json['image'],
        status = json['status'],
        views = json['views'];
}
