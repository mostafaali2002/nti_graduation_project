import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/features/auth/domain/entities/register_request_entity.dart';
import 'package:nti_graduation_project/features/auth/domain/use_case/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(RegisterInitial());
  final RegisterUseCase _registerUseCase;
  Future<void> intent(RegisterIntint intint) async {
    switch (intint) {
      case RegisterIntintRegister():
        _register(intint.requst);
    }
  }

  Future<void> _register(RegisterRequestEntity requst) async {
    final result = await _registerUseCase.invoke(requst);
    switch (result) {
      case Success<String>():
        emit(RegisterSuccess());

      case Error<String>():
        emit(RegisterErorr(result.messageError));
    }
  }
}

sealed class RegisterIntint {}

class RegisterIntintRegister extends RegisterIntint {
  final RegisterRequestEntity requst;

  RegisterIntintRegister(this.requst);
}
