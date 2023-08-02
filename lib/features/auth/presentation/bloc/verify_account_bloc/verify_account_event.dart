part of 'verify_account_bloc.dart';

@immutable
abstract class VerifyAccountEvent {}

class VerifyUserAccount extends VerifyAccountEvent {}

class SetVerificationCode extends VerifyAccountEvent {
  final String code;

  SetVerificationCode({required this.code});
}
