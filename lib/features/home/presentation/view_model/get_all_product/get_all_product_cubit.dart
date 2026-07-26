import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import 'package:nti_graduation_project/features/home/domain/use_case/get_all_product_use_case.dart';

part 'get_all_product_state.dart';

class GetAllProductCubit extends Cubit<GetAllProductState> {
  GetAllProductCubit({required this._getAllProductUseCase})
    : super(GetAllProductInitial());
  final GetAllProductUseCase _getAllProductUseCase;

  Future<void> getAllProduct() async {
    final result = await _getAllProductUseCase.invoke();
    switch (result) {
      case Success<AllProductEntity>():
        emit(GetAllProductSuccess(result.data.productList));
      case Error<AllProductEntity>():
        emit(GetAllProductFailure(result.messageError));
    }
  }
}
