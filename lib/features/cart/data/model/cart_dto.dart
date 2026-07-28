import 'package:nti_graduation_project/features/cart/domain/entities/cart_entity.dart';
import 'package:nti_graduation_project/features/home/data/model/all_product_model/all_product_dto.dart';

class CartDto {
  List<ProductListDto>? list;

  CartDto({this.list});

  CartDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null ) {
      list = (json['list'] as List)
          .map((e) => ProductListDto.fromJson(e))
          .toList();
    }
  }

  CartEntity toEntity() {
    return CartEntity(
      productList: list?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}