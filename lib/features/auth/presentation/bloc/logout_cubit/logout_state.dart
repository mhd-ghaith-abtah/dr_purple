part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LoggingOut extends LogoutState {}

class LoggedOut extends LogoutState {}

class LogoutError extends LogoutState {
  final String errorMessage;

  LogoutError({required this.errorMessage});
}
