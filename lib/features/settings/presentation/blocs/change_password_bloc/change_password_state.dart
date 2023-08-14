part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {
  final ChangePasswordBlocStateType loadingType;

  ChangePasswordLoading({required this.loadingType});
}

class ChangePasswordLoaded extends ChangePasswordState {
  final ChangePasswordBlocStateType loadedType;

  ChangePasswordLoaded({required this.loadedType});
}

class ChangePasswordError extends ChangePasswordState {
  final ChangePasswordBlocStateType errorType;
  final String errorMessage;

  ChangePasswordError({required this.errorType, required this.errorMessage});
}

enum ChangePasswordBlocStateType { server, validateInput }
