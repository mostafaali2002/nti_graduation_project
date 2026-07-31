part of 'account_cubit.dart';

sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountSucess extends AccountState {}

final class AccountError extends AccountState {
  final String errorMessage;

  AccountError({required this.errorMessage});
}

final class AccountLoading extends AccountState {}
