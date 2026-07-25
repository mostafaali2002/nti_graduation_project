import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_data_source_interface.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_repo_interface.dart';

class HomeRepoImp implements HomeRepoInterface {
  HomeDataSourceInterface _homeDataSourceInterface;
  HomeRepoImp(this._homeDataSourceInterface);
  @override
  Future<ResultApi<AllProductEntity>> getAllProducts({String? token}) =>
      _homeDataSourceInterface.getAllProducts(token: "");

  @override
  Future<ResultApi<CategoryEntity>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
}
