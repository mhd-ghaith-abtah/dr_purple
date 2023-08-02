part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {
  final RegisterBlocStateType loadingType;

  RegisterLoading({required this.loadingType});
}

class RegisterLoaded extends RegisterState {
  final RegisterBlocStateType loadedType;

  RegisterLoaded({required this.loadedType});
}

class RegisterError extends RegisterState {
  final RegisterBlocStateType errorType;
  final String errorMessage;

  RegisterError({required this.errorType, required this.errorMessage});
}

enum RegisterBlocStateType { server, genderSelected, validateInput }
