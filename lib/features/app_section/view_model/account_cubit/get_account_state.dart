import 'package:nti_graduation_project/features/account/domain/entities/get_account_entity.dart';

sealed class GetAccountState {}

final class GetAccountInitial extends GetAccountState {}

final class GetAccountSucess extends GetAccountState {
  final GetProfileEntity data;

  GetAccountSucess({required this.data});
}

final class GetAccountError extends GetAccountState {
  final String errorMessage;

  GetAccountError({required this.errorMessage});
}

final class GetAccountLoading extends GetAccountState {}
