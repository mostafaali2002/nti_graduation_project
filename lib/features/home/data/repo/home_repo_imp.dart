import 'package:nti_graduation_project/core/api/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_repo_interface.dart';

class HomeRepoImp implements HomeRepoInterface {
  @override
  Future<ResultApi<AllProductEntity>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<ResultApi<CategoryEntity>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
}
