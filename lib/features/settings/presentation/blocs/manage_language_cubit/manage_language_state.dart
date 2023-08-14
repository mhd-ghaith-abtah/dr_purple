part of 'manage_language_cubit.dart';

@immutable
abstract class ManageLanguageState {}

class ManageLanguageInitial extends ManageLanguageState {}

class ChangingAppLanguage extends ManageLanguageState {}

class ErrorChangingAppLanguage extends ManageLanguageState {
  final String errorMessage;

  ErrorChangingAppLanguage({required this.errorMessage});
}

class AppLanguageChanged extends ManageLanguageState {}

class LanguageScreenStateManaged extends ManageLanguageState {}

class InitializingLanguageScreen extends ManageLanguageState {}

class LanguageScreenInitialized extends ManageLanguageState {}
