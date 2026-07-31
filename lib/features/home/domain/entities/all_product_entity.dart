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
  String availabilityStatus;
  List<String> images;
  String thumbnail;
  int stock;
  List<ReviewEntity> reviews;

  ProductListEntity({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.discountPercentage = 0.0,
    this.rating = 0.0,
    this.availabilityStatus = '',
    this.images = const [],
    this.reviews = const [],
    this.thumbnail = "",
    this.stock = 0,
  });
}

class ReviewEntity {
  int rating;
  String comment;
  String date;
  String reviewerName;
  String reviewerEmail;

  ReviewEntity({
    this.rating = 0,
    this.comment = '',
    this.date = '',
    this.reviewerName = '',
    this.reviewerEmail = '',
  });
}
