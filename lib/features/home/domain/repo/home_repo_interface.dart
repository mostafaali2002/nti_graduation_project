import 'package:nti_graduation_project/core/api/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';

abstract class HomeRepoInterface {
  Future<ResultApi<CategoryEntity>> getCategories();
  Future<ResultApi<AllProductEntity>> getAllProducts();
}
