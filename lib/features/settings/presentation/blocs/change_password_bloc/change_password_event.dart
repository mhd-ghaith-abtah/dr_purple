part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}

class SetOldPassword extends ChangePasswordEvent {
  final String oldPassword;

  SetOldPassword(this.oldPassword);
}

class SetNewPassword extends ChangePasswordEvent {
  final String newPassword;

  SetNewPassword(this.newPassword);
}

class SetRepeatNewPassword extends ChangePasswordEvent {
  final String repeatNewPassword;

  SetRepeatNewPassword(this.repeatNewPassword);
}

class ChangePasswordValidateInputEvent extends ChangePasswordEvent {}

class SendChangePasswordEvent extends ChangePasswordEvent {}
