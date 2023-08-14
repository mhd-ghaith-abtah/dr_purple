part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {
  final ForgetPasswordBlocStateType loadingType;

  ForgetPasswordLoading({required this.loadingType});
}

class ForgetPasswordLoaded extends ForgetPasswordState {
  final ForgetPasswordBlocStateType loadedType;

  ForgetPasswordLoaded({required this.loadedType});
}

class ForgetPasswordError extends ForgetPasswordState {
  final ForgetPasswordBlocStateType errorType;
  final String errorMessage;

  ForgetPasswordError({required this.errorType, required this.errorMessage});
}

enum ForgetPasswordBlocStateType { server, validateInput }
