import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import '../repo/search_repo_interface.dart';


class SearchProductsUseCase {
  final SearchRepoInterface searchRepo;

  SearchProductsUseCase({required this.searchRepo});

  Future<ResultApi<AllProductEntity>> call({
    required String query,
    int skip = 0,
    int limit = 10,
  }) {
    return searchRepo.searchProducts(
      query: query,
      skip: skip,
      limit: limit,
    );
  }
}