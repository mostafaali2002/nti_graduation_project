import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_repo_interface.dart';

class GetProductsByCategoryUseCase {
  final HomeRepoInterface _homeRepoInterface;
  GetProductsByCategoryUseCase(this._homeRepoInterface);

  Future<ResultApi<AllProductEntity>> invoke({
    required String slug,
    int skip = 0,
    int limit = 5,
  }) async => await _homeRepoInterface.getProductsByCategory(
    slug: slug,
    skip: skip,
    limit: limit,
  );
}
