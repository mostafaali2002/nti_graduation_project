import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';

class CartEntity {
  final List<ProductListEntity> productList;

  const CartEntity({
    this.productList = const [],
  });
}
