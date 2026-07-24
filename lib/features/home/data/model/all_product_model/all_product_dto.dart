class AllProductDto {
  List<ProductList>? productList;

  AllProductDto({this.productList});

  AllProductDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      productList = [];
      json['list'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
  }
}

class ProductList {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  List<String>? tags;
  String? availabilityStatus;
  List<String>? images;

  ProductList({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.tags,
    this.availabilityStatus,
    this.images,
  });

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    tags = json['tags'].cast<String>();
    availabilityStatus = json['availabilityStatus'];
  }
}
