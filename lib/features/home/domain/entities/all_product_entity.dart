class AllProductEntity {
  List<ProductListEntity> productList;

  AllProductEntity({this.productList = const []});
}

class ProductListEntity {
  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  double rating;
  List<String> tags;
  String availabilityStatus;
  List<String> images;

  ProductListEntity({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.discountPercentage = 0.0,
    this.rating = 0.0,
    this.tags = const [],
    this.availabilityStatus = '',
    this.images = const [],
  });
}
