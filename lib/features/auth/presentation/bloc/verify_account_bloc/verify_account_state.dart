part of 'verify_account_bloc.dart';

@immutable
abstract class VerifyAccountState {}

class VerifyAccountInitial extends VerifyAccountState {}

class VerifyAccountLoading extends VerifyAccountState {
  final VerifyAccountBlocStateType loadingType;

  VerifyAccountLoading({required this.loadingType});
}

class VerifyAccountLoaded extends VerifyAccountState {
  final VerifyAccountBlocStateType loadedType;

  VerifyAccountLoaded({required this.loadedType});
}

class VerifyAccountError extends VerifyAccountState {
  final VerifyAccountBlocStateType errorType;
  final String errorMessage;

  VerifyAccountError({required this.errorType, required this.errorMessage});
}

enum VerifyAccountBlocStateType { server, setCode }
