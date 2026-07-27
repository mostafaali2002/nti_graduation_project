import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_repo_interface.dart';

class GetCategoriesUseCase {
  final HomeRepoInterface _homeRepoInterface;
  GetCategoriesUseCase(this._homeRepoInterface);
  Future<ResultApi<CategoryEntity>> invoke() async =>
      await _homeRepoInterface.getCategories();
}
