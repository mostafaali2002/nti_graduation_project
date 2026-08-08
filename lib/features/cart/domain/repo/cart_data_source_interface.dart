import 'package:nti_graduation_project/features/cart/domain/entities/cart_entity.dart';
import '../../../../core/network/result_api.dart';

abstract class CartDataSourceInterface {
  Future<ResultApi<CartEntity>> getCart();

  Future<ResultApi<String>> addCart({
    required String productId,
  });

  Future<ResultApi<String>> deleteCart({
    required String productId,
  });
}