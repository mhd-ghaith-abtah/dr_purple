part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LogUserInEvent extends LoginEvent {}

class SetLoginPassword extends LoginEvent {
  final String password;

  SetLoginPassword(this.password);
}

class SetLoginUsername extends LoginEvent {
  final String username;

  SetLoginUsername(this.username);
}

class LoginValidateInputEvent extends LoginEvent {}
