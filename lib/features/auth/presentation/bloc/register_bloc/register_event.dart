part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {}

class SetRegisterPassword extends RegisterEvent {
  final String password;

  SetRegisterPassword(this.password);
}

class SetRegisterEmail extends RegisterEvent {
  final String email;

  SetRegisterEmail(this.email);
}

class SetRegisterPhoneNumber extends RegisterEvent {
  final String phoneNumber;

  SetRegisterPhoneNumber(this.phoneNumber);
}

class SetRegisterUsername extends RegisterEvent {
  final String username;

  SetRegisterUsername(this.username);
}

class SetRegisterFirstName extends RegisterEvent {
  final String firstName;

  SetRegisterFirstName(this.firstName);
}

class SetRegisterLastName extends RegisterEvent {
  final String lastName;

  SetRegisterLastName(this.lastName);
}

class SetRegisterGender extends RegisterEvent {
  final Gender gender;

  SetRegisterGender(this.gender);
}

class RegisterValidateInputEvent extends RegisterEvent {}
