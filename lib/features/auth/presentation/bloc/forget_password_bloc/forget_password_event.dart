part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordEvent {}

class SendForgetPasswordEvent extends ForgetPasswordEvent {}

class SetForgetPasswordPhoneNumber extends ForgetPasswordEvent {
  final String phoneNumber;

  SetForgetPasswordPhoneNumber(this.phoneNumber);
}

class ForgetPasswordValidateInputEvent extends ForgetPasswordEvent {}
