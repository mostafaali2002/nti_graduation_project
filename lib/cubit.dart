import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/states.dart';

class HomeCubit extends Cubit<States> {
  HomeCubit() : super(Initial());
  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void move(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}
