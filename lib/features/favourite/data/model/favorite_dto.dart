import 'package:nti_graduation_project/features/favourite/domain/entities/favorite_entity.dart';

import '../../../home/data/model/all_product_model/all_product_dto.dart';

class FavoriteDto {
  List<ProductListDto> list = [];

  FavoriteDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] == null) return;

    for (final item in json['list']) {
      
      if (item['list'] != null) {
        list.addAll(
          (item['list'] as List)
              .map((e) => ProductListDto.fromJson(e))
              .toList(),
        );
      }
      else {
        list.add(ProductListDto.fromJson(item));
      }
    }
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      productList: list.map((e) => e.toEntity()).toList(),
    );
  }
}