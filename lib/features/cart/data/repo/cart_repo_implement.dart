import 'package:nti_graduation_project/features/cart/domain/entities/cart_entity.dart';
import 'package:nti_graduation_project/features/cart/domain/repo/cart_data_source_interface.dart';
import 'package:nti_graduation_project/features/cart/domain/repo/cart_repo_interface.dart';
import '../../../../core/network/result_api.dart';

class CartRepoImp implements CartRepoInterface {
  final CartDataSourceInterface cartDataSource;

  CartRepoImp({required this.cartDataSource});

  @override
  Future<ResultApi<CartEntity>> getCart() async {
    return await cartDataSource.getCart();
  }

  @override
  Future<ResultApi<String>> addCart({
    required String productId,
  }) async {
    return await cartDataSource.addCart(
      productId: productId,
    );
  }

  @override
  Future<ResultApi<String>> deleteCart({
    required String productId,
  }) async {
    return await cartDataSource.deleteCart(
      productId: productId,
    );
  }
}