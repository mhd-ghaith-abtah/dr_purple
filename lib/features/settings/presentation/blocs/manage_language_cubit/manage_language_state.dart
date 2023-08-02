part of 'manage_language_cubit.dart';

@immutable
abstract class ManageLanguageState {}

class ManageLanguageInitial extends ManageLanguageState {}

class ChangingAppLanguage extends ManageLanguageState {}

class AppLanguageChanged extends ManageLanguageState {}

class LanguageScreenStateManaged extends ManageLanguageState {}

class InitializingLanguageScreen extends ManageLanguageState {}

class LanguageScreenInitialized extends ManageLanguageState {}
