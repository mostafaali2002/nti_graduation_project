import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/repo/home_data_source_interface.dart';

import '../../domain/repo/search_repo_interface.dart';

class SearchRepoImp implements SearchRepoInterface {
  final HomeDataSourceInterface homeDataSource;

  SearchRepoImp({required this.homeDataSource});

  @override
  Future<ResultApi<AllProductEntity>> searchProducts({
    required String query,
    int skip = 0,
    int limit = 10,
  }) {
    return homeDataSource.searchProducts(
      query: query,
      skip: skip,
      limit: limit,
    );
  }
}