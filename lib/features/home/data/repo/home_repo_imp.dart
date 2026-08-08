import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_data_source_interface.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_repo_interface.dart';

class HomeRepoImp implements HomeRepoInterface {
  final HomeDataSourceInterface _homeDataSourceInterface;
  HomeRepoImp(this._homeDataSourceInterface);
  @override
  Future<ResultApi<AllProductEntity>> getAllProducts() =>
      _homeDataSourceInterface.getAllProducts();

  @override
  Future<ResultApi<CategoryEntity>> getCategories() =>
      _homeDataSourceInterface.getCategories();

  @override
  Future<ResultApi<AllProductEntity>> getProductsByCategory({
    required String slug,
    int skip = 0,
    int limit = 5,
  }) => _homeDataSourceInterface.getProductsByCategory(
    slug: slug,
    skip: skip,
    limit: limit,
  );
}
