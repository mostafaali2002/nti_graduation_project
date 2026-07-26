import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  GetCategoryCubit() : super(GetCategoryInitial());
}
