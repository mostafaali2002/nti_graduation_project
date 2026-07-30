import 'package:nti_graduation_project/features/home/domain/entities/account_entity.dart';

sealed class GetAccountState {}

final class GetAccountInitial extends GetAccountState {}

final class GetAccountSucess extends GetAccountState {
  final ProfileEntity data;

  GetAccountSucess({required this.data});
}

final class GetAccountError extends GetAccountState {
  final String errorMessage;

  GetAccountError({required this.errorMessage});
}

final class GetAccountLoading extends GetAccountState {}
