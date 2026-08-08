import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';
import 'package:nti_graduation_project/features/home/domain/use_case/get_item_use_case.dart';

part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  GetCategoryCubit(this._getCategoriesUseCase) : super(GetCategoryInitial());
  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> getcatgories() async {
    final result = await _getCategoriesUseCase.invoke();
    switch (result) {
      case Success<CategoryEntity>():
        emit(GetCategorySuccess(result.data.categoryList));
      case Error<CategoryEntity>():
        emit(GetCategoryFailure(result.messageError));
    }
  }
}
