import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/app_section/view_model/account_cubit/get_account_state.dart';
import 'package:nti_graduation_project/features/account/domain/entities/account_entity.dart';
import 'package:nti_graduation_project/features/account/domain/use_case/get_account_info_use_case.dart';
import 'package:nti_graduation_project/features/account/domain/entities/get_account_entity.dart';

@injectable
class GetAccountCubit extends Cubit<GetAccountState> {
  GetAccountCubit({required this._accountInfoUseCase})
    : super(GetAccountInitial());
  final GetAccountUseCase _accountInfoUseCase;
  Future<void> intent(GetAccountIntint intint) async {
    switch (intint) {
      case GetAccountIntintEdite():
        getData();
    }
  }

  Future<void> getData() async {
    final result = await _accountInfoUseCase.invoke();
    switch (result) {
      case Success<GetProfileEntity>():
        emit(GetAccountSucess(data: result.data));
      case Error<GetProfileEntity>():
        emit(GetAccountError(errorMessage: result.messageError));
    }
  }
}

sealed class GetAccountIntint {}

class GetAccountIntintEdite extends GetAccountIntint {
  final ProfileEntity requst;

  GetAccountIntintEdite(this.requst);
}
