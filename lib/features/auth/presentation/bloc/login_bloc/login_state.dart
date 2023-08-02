part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final LoginBlocStateType loadingType;

  LoginLoading({required this.loadingType});
}

class LoginLoaded extends LoginState {
  final LoginBlocStateType loadedType;

  LoginLoaded({required this.loadedType});
}

class LoginError extends LoginState {
  final LoginBlocStateType errorType;
  final String errorMessage;

  LoginError({required this.errorType, required this.errorMessage});
}

enum LoginBlocStateType { server, validateInput }
