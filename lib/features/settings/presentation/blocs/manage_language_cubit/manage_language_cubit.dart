import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/settings/data/models/params/change_language/change_language_params.dart';
import 'package:dr_purple/features/settings/domain/use_cases/change_language_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_language_state.dart';

class ManageLanguageCubit extends Cubit<ManageLanguageState> {
  final LanguageManager _languageManager;
  final ChangeLanguageUseCase _changeLanguageUseCase;

  ManageLanguageCubit(this._languageManager, this._changeLanguageUseCase)
      : super(ManageLanguageInitial());
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
    emit(ChangingAppLanguage());
    String errorMessage = Constants.empty;
    var res = await _changeLanguageUseCase.call(ChangeLanguageParams(
      body: ChangeLanguageParamsBody(
        newLanguage: selectedLanguage.toString(),
      ),
    ));
    bool isError = res.fold((l) {
      errorMessage = l.message;
      return true;
    }, (r) => false);
    if (isError) {
      emit(ErrorChangingAppLanguage(errorMessage: errorMessage));
    } else {
      await _languageManager
          .setLocal(selectedLanguage!)
          .then((newLocale) async => await context.setLocale(newLocale));
      emit(AppLanguageChanged());
    }
  }
}
