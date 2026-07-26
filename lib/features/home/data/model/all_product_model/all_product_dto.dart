import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';

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
  AllProductEntity toEntity() {
    return AllProductEntity(
      productList: productList?.map((e) => e.toEntity()).toList() ?? [],
    );
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
  ProductListEntity toEntity() {
    return ProductListEntity(
      id: id ?? 0,
      title: title ?? '',
      description: description ?? '',
      category: category ?? '',
      price: price ?? 0.0,
      discountPercentage: discountPercentage ?? 0.0,
      rating: rating ?? 0.0,
      availabilityStatus: availabilityStatus ?? '',
      images: images ?? [],
    );
  }
}
