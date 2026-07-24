import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/features/app_section/view_model/app_section_states.dart';
class AppSectionCubit extends Cubit<AppSectionState> {
  AppSectionCubit() : super(AppSectionInitial());

  int currentIndex = 0;

  void changeTab(int index) {
    if (currentIndex == index) return;

    currentIndex = index;
    emit(AppSectionChangeTabState());
  }
}
