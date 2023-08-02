import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/storage/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final AppPreferences _appPreferences;
  bool _isThemeDark = false;

  bool get isThemeDark => _isThemeDark;

  ThemeCubit(this._appPreferences) : super(ThemeInitial());

  void initTheme() {
    _isThemeDark = _appPreferences.getDarkTheme() ?? false;
    if (_isThemeDark) {
      ColorManager.textPrimaryColor = Colors.white;
      ColorManager.textSecondaryColor = Colors.white;
      shadowColorGlobal = ColorManager.appShadowColorDark;
    } else {
      ColorManager.textPrimaryColor = ColorManager.appTextColorPrimary;
      ColorManager.textSecondaryColor = ColorManager.appTextColorSecondary;
      shadowColorGlobal = ColorManager.appShadowColor;
    }
    emit(ThemeChanged());
  }

  Future<void> toggleTheme() async {
    _isThemeDark = !_isThemeDark;
    await _appPreferences.setDarkTheme(darkThemeValue: _isThemeDark);
    if (_isThemeDark) {
      ColorManager.textPrimaryColor = Colors.white;
      ColorManager.textSecondaryColor = Colors.white;
      shadowColorGlobal = ColorManager.appShadowColorDark;
    } else {
      ColorManager.textPrimaryColor = ColorManager.appTextColorPrimary;
      ColorManager.textSecondaryColor = ColorManager.appTextColorSecondary;
      shadowColorGlobal = ColorManager.appShadowColor;
    }
    emit(ThemeChanged());
  }
}
