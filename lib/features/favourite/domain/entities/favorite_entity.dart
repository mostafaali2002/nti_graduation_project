class FavoriteEntity {
  final List<FavoriteItemEntity> item;

  FavoriteEntity({
    this.item = const [],
  });

  factory FavoriteEntity.fromJson(Map<String, dynamic> json) {
    return FavoriteEntity(
      item: json['list'] != null
          ? (json['list'] as List)
              .map((v) => FavoriteItemEntity.fromJson(v as Map<String, dynamic>))
              .toList()
          : (json['item'] != null
              ? (json['item'] as List)
                  .map((v) => FavoriteItemEntity.fromJson(v as Map<String, dynamic>))
                  .toList()
              : const []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item.map((v) => v.toJson()).toList(),
    };
  }
}

class FavoriteItemEntity {
  final List<ProductEntity> products;
  final int total;
  final int skip;
  final int limit;

  FavoriteItemEntity({
    this.products = const [],
    this.total = 0,
    this.skip = 0,
    this.limit = 0,
  });

  factory FavoriteItemEntity.fromJson(Map<String, dynamic> json) {
    return FavoriteItemEntity(
      products: json['list'] != null
          ? (json['list'] as List)
              .map((v) => ProductEntity.fromJson(v as Map<String, dynamic>))
              .toList()
          : const [],
      total: json['total'] as int? ?? 0,
      skip: json['skip'] as int? ?? 0,
      limit: json['limit'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': products.map((v) => v.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}

class ProductEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final DimensionsEntity dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ReviewEntity> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final MetaEntity meta;
  final List<String> images;
  final String thumbnail;

  ProductEntity({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.discountPercentage = 0.0,
    this.rating = 0.0,
    this.stock = 0,
    this.tags = const [],
    this.brand = '',
    this.sku = '',
    this.weight = 0,
    DimensionsEntity? dimensions,
    this.warrantyInformation = '',
    this.shippingInformation = '',
    this.availabilityStatus = '',
    this.reviews = const [],
    this.returnPolicy = '',
    this.minimumOrderQuantity = 1,
    MetaEntity? meta,
    this.images = const [],
    this.thumbnail = '',
  })  : dimensions = dimensions ?? DimensionsEntity(),
        meta = meta ?? MetaEntity();

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : const [],
      brand: json['brand'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      weight: json['weight'] as int? ?? 0,
      dimensions: json['dimensions'] != null
          ? DimensionsEntity.fromJson(json['dimensions'] as Map<String, dynamic>)
          : DimensionsEntity(),
      warrantyInformation: json['warrantyInformation'] as String? ?? '',
      shippingInformation: json['shippingInformation'] as String? ?? '',
      availabilityStatus: json['availabilityStatus'] as String? ?? '',
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((v) => ReviewEntity.fromJson(v as Map<String, dynamic>))
              .toList()
          : const [],
      returnPolicy: json['returnPolicy'] as String? ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] as int? ?? 1,
      meta: json['meta'] != null
          ? MetaEntity.fromJson(json['meta'] as Map<String, dynamic>)
          : MetaEntity(),
      images: json['images'] != null ? List<String>.from(json['images']) : const [],
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((v) => v.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}

class DimensionsEntity {
  final double width;
  final double height;
  final double depth;

  DimensionsEntity({
    this.width = 0.0,
    this.height = 0.0,
    this.depth = 0.0,
  });

  factory DimensionsEntity.fromJson(Map<String, dynamic> json) {
    return DimensionsEntity(
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      depth: (json['depth'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }
}

class ReviewEntity {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  ReviewEntity({
    this.rating = 0,
    this.comment = '',
    this.date = '',
    this.reviewerName = '',
    this.reviewerEmail = '',
  });

  factory ReviewEntity.fromJson(Map<String, dynamic> json) {
    return ReviewEntity(
      rating: json['rating'] as int? ?? 0,
      comment: json['comment'] as String? ?? '',
      date: json['date'] as String? ?? '',
      reviewerName: json['reviewerName'] as String? ?? '',
      reviewerEmail: json['reviewerEmail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class MetaEntity {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  MetaEntity({
    this.createdAt = '',
    this.updatedAt = '',
    this.barcode = '',
    this.qrCode = '',
  });

  factory MetaEntity.fromJson(Map<String, dynamic> json) {
    return MetaEntity(
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      barcode: json['barcode'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }
}