import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_language_state.dart';

class ManageLanguageCubit extends Cubit<ManageLanguageState> {
  final LanguageManager _languageManager;

  ManageLanguageCubit(this._languageManager) : super(ManageLanguageInitial());
  Language? selectedLanguage;

  void init() {
    emit(InitializingLanguageScreen());
    selectedLanguage = _languageManager.appCurrentLanguage;
    emit(LanguageScreenInitialized());
  }

  void manageScreen(Language newLanguage) {
    selectedLanguage = newLanguage;
    emit(LanguageScreenStateManaged());
  }

  Future<void> changeAppLanguage(BuildContext context) async {
    await _languageManager
        .setLocal(selectedLanguage!)
        .then((newLocale) async => await context.setLocale(newLocale));
    emit(AppLanguageChanged());
  }
}
