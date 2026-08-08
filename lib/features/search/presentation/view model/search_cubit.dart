import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/search/presentation/view%20model/search_states.dart';

import '../../domain/use_case/search_use_case.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase searchProductsUseCase;

  SearchCubit({required this.searchProductsUseCase}) : super(SearchInitial());

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }


    emit(SearchLoading());

    final result = await searchProductsUseCase(
      query: query,
      limit: 10,
    );

    switch (result) {
      case Success<AllProductEntity>():
        final products = result.data.productList;
        if (products.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchSuccess(products));
        }

      case Error<AllProductEntity>():
        emit(SearchFailure(result.messageError));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}