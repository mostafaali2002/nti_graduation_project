import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/features/app_section/view_model/app_section_states.dart';
class AppSectionCubit extends Cubit<AppSectionStates> {
  AppSectionCubit() : super(Initial());
  static AppSectionCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void move(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}
