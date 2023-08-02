import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  static const languageKey = "LANGUAGE_KEY";
  static const accessTokenKey = "ACCESS_TOKEN_KEY";
  static const refreshTokenKey = "REFRESH_TOKEN_KEY";
  static const userSignedInKey = "USER_SIGNED_IN_KEY";
  static const lastRouteKey = "LAST_ROUTE_KEY";
  static const darkThemeKey = "DARK_THEME_KEY";
  static const userInfoKey = "USER_INFO_KEY";
  static const openFirstTimeKey = "OPEN_FIRST_TIME_KEY";

  Language? getAppLanguage() {
    String? language = _sharedPreferences.getString(languageKey);
    return language != null && language.trim().isNotEmpty
        ? language == Language.ar.name
            ? Language.ar
            : Language.en
        : null;
  }

  Future<void> setAppLanguage({required Language languageValue}) async =>
      await _sharedPreferences.setString(languageKey, languageValue.name);

  String? getAccessToken() =>
      "Bearer ${_sharedPreferences.getString(accessTokenKey)}";

  Future<void> setAccessToken({
    required String accessTokenValue,
  }) async {
    await _sharedPreferences.setString(accessTokenKey, accessTokenValue).then(
        (value) async =>
            await _sharedPreferences.setBool(userSignedInKey, true));
  }

  String? getRefreshToken() => _sharedPreferences.getString(refreshTokenKey);

  Future<void> setRefreshToken({
    required String refreshTokenValue,
  }) async =>
      await _sharedPreferences.setString(refreshTokenKey, refreshTokenValue);

  bool getUserSignedIn() =>
      _sharedPreferences.getBool(userSignedInKey) ?? false;

  Future<void> setLastRoute({
    required String lastRouteValue,
  }) async =>
      await _sharedPreferences.setString(lastRouteKey, lastRouteValue);

  String? getLastRoute() => _sharedPreferences.getString(lastRouteKey);

  Future<bool> removeLastRoute() async =>
      await _sharedPreferences.remove(lastRouteKey);

  Future<void> setDarkTheme({
    required bool darkThemeValue,
  }) async =>
      await _sharedPreferences.setBool(darkThemeKey, darkThemeValue);

  bool? getDarkTheme() => _sharedPreferences.getBool(darkThemeKey);

  Future<void> setOpenFirstTime({
    required bool openFirstTimeValue,
  }) async =>
      await _sharedPreferences.setBool(openFirstTimeKey, openFirstTimeValue);

  bool getOpenFirstTimeValue() =>
      _sharedPreferences.getBool(openFirstTimeKey) ?? true;

  Future<void> reload() async => await _sharedPreferences.reload();

  Future<void> setUserInfo({
    required String phoneNumber,
  }) async =>
      await _sharedPreferences.setString(userInfoKey, phoneNumber);

  String? getUserInfo() => _sharedPreferences.getString(userInfoKey);

  Future<bool> removeUserInfo() async => _sharedPreferences.remove(userInfoKey);

  Future<void> clearAppPreferences() async {
    final lang = getAppLanguage();
    await _sharedPreferences.clear().then(
        (value) => lang != null ? setAppLanguage(languageValue: lang) : null);
  }
}
