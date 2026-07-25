import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_all_product_state.dart';

class GetAllProductCubit extends Cubit<GetAllProductState> {
  GetAllProductCubit() : super(GetAllProductInitial());
}
