import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/home/domain/entities/account_entity.dart';
import 'package:nti_graduation_project/features/account/domain/use_case/post_account_info_use_case.dart';

part 'account_state.dart';

@injectable
class AccountCubit extends Cubit<AccountState> {
  AccountCubit({required this._accountInfoUseCase}) : super(AccountInitial());
  final PostAccountInfoUseCase _accountInfoUseCase;
  Future<void> intent(AccountIntint intint) async {
    switch (intint) {
      case AccountIntintEdite():
        accountEdit(intint.requst);
    }
  }

  Future<void> accountEdit(ProfileEntity request) async {
    emit(AccountLoading());
    final result = await _accountInfoUseCase.invoke(request);
    switch (result) {
      case Success<String>():
        emit(AccountSucess());
      case Error<String>():
        emit(AccountError(errorMessage: result.messageError));
    }
  }
}

sealed class AccountIntint {}

class AccountIntintEdite extends AccountIntint {
  final ProfileEntity requst;

  AccountIntintEdite(this.requst);
}
