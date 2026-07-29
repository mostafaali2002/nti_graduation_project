import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';

abstract class SearchRepoInterface {
  Future<ResultApi<AllProductEntity>> searchProducts({
    required String query,
    int skip = 0,
    int limit = 10,
  });
}