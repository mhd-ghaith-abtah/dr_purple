part of 'verify_forget_password_bloc.dart';

@immutable
abstract class VerifyForgetPasswordState {}

class VerifyForgetPasswordInitial extends VerifyForgetPasswordState {}

class VerifyForgetPasswordLoading extends VerifyForgetPasswordState {
  final VerifyForgetPasswordBlocStateType loadingType;

  VerifyForgetPasswordLoading({required this.loadingType});
}

class VerifyForgetPasswordLoaded extends VerifyForgetPasswordState {
  final VerifyForgetPasswordBlocStateType loadedType;

  VerifyForgetPasswordLoaded({required this.loadedType});
}

class VerifyForgetPasswordError extends VerifyForgetPasswordState {
  final VerifyForgetPasswordBlocStateType errorType;
  final String errorMessage;

  VerifyForgetPasswordError(
      {required this.errorType, required this.errorMessage});
}

enum VerifyForgetPasswordBlocStateType { server, validateInput }
