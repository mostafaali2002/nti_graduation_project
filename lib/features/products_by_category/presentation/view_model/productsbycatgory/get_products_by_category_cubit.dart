import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/use_case/get_products_by_category_use_case.dart';

part 'get_products_by_category_state.dart';

class GetProductsByCategoryCubit extends Cubit<GetProductsByCategoryState> {
  GetProductsByCategoryCubit({required this._getProductsByCategoryUseCase})
    : super(GetProductsByCategoryInitial());
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;

  Future<void> getProductsByCategory({
    required String slug,
    int? skip,
    int? limit,
  }) async {
    emit(GetProductsByCategoryLoading());
    final result = await _getProductsByCategoryUseCase.invoke(
      slug: slug,
      skip: skip ?? 0,
      limit: limit ?? 5,
    );
    switch (result) {
      case Success<AllProductEntity>():
        {
          emit(GetProductsByCategorySuccess(result.data.productList));
        }
      case Error<AllProductEntity>():
        emit(GetProductsByCategoryFailure(result.messageError));
    }
  }
}
