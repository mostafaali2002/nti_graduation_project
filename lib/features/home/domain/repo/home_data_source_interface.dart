import 'package:nti_graduation_project/core/api/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';

abstract class HomeDataSourceInterface {
  Future<ResultApi<CategoryEntity>> getCategories();
}
