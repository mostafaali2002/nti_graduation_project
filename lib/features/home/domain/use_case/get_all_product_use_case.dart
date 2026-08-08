import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_repo_interface.dart';

class GetAllProductUseCase {
  final HomeRepoInterface _homeRepoInterface;
  GetAllProductUseCase(this._homeRepoInterface);
  Future<ResultApi<AllProductEntity>> invoke() async =>
      await _homeRepoInterface.getAllProducts();
}
