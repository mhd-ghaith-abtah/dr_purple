part of 'verify_forget_password_bloc.dart';

@immutable
abstract class VerifyForgetPasswordEvent {}

class SetVerifyForgetPasswordCode extends VerifyForgetPasswordEvent {
  final String code;

  SetVerifyForgetPasswordCode({required this.code});
}

class SetVerifyForgetPasswordNewPassword extends VerifyForgetPasswordEvent {
  final String newPassword;

  SetVerifyForgetPasswordNewPassword({required this.newPassword});
}

class SetVerifyForgetPasswordRepeatNewPassword
    extends VerifyForgetPasswordEvent {
  final String newPasswordRepeat;

  SetVerifyForgetPasswordRepeatNewPassword({required this.newPasswordRepeat});
}

class SendVerifyForgetPasswordEvent extends VerifyForgetPasswordEvent {
  final String phoneNumber;

  SendVerifyForgetPasswordEvent({required this.phoneNumber});
}

class VerifyForgetPasswordValidateInputEvent
    extends VerifyForgetPasswordEvent {}
