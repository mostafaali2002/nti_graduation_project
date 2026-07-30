import '../../../domain/entities/all_product_entity.dart';

class AllProductDto {
  List<ProductListDto>? productList;

  AllProductDto({this.productList});

  AllProductDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      productList = [];
      json['list'].forEach((v) {
        productList!.add(ProductListDto.fromJson(v));
      });
    }
  }

  AllProductEntity toEntity() {
    return AllProductEntity(
      productList: productList?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class ProductListDto {
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
  String? thumbnail;
  int? stock;
  List<ReviewDto>? reviews;

  ProductListDto({
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
    this.thumbnail,
    this.stock,
    this.reviews,
  });

  ProductListDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    tags = json['tags']?.cast<String>();
    availabilityStatus = json['availabilityStatus'];
    images = List<String>.from(json['images'] ?? []);
    thumbnail = json['thumbnail'];
    stock = json['stock'] ?? 0;
    reviews = (json['reviews'] as List? ?? [])
        .map((v) => ReviewDto.fromJson(v))
        .toList();
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
      thumbnail: thumbnail ?? '',
      stock: stock ?? 0,
      reviews: reviews?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class ReviewDto {
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  ReviewDto({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  ReviewDto.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      rating: rating ?? 0,
      comment: comment ?? '',
      date: date ?? '',
      reviewerName: reviewerName ?? '',
      reviewerEmail: reviewerEmail ?? '',
    );
  }
}
