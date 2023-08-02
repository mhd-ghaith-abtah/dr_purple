import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/storage/app_preferences.dart';
import 'package:dr_purple/app/storage/database/dr_purple_database.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/refresh/refresh_params.dart';
import 'package:dr_purple/features/auth/domain/entities/refresh_entity.dart';
import 'package:dr_purple/features/auth/domain/use_cases/refresh_use_case.dart';
import 'package:easy_localization/easy_localization.dart';

class RefreshAccessToken {
  final AppPreferences _appPreferences;
  final RefreshUseCase _refreshUseCase;

  RefreshAccessToken(this._appPreferences, this._refreshUseCase);

  Future<bool> refresh() async {
    RefreshEntity? refreshEntity;
    ErrorEntity? errorEntity;

    /// get refresh token from app shared preferences
    String refreshToken = _appPreferences.getRefreshToken() ?? Constants.empty;
    String accessToken = _appPreferences.getAccessToken() ?? Constants.empty;

    /// get new access token from server
    var res = await _refreshUseCase.call(
      RefreshParams(
        body: RefreshParamsBody(
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      ),
    );

    /// check if an error occurred during API request
    bool isRefreshError = res.fold((l) {
      errorEntity = l;
      return true;
    }, (r) {
      refreshEntity = r;
      return false;
    });
    if (isRefreshError) {
      if (errorEntity?.statusCode == ResponseCode.unAuthorized) {
        _clearDatabase();
        while (RouteGenerator.router.canPop()) {
          RouteGenerator.router.pop();
        }
        RouteGenerator.router.replace("/${Routes.loginRoute}");
        await Utils.showToast(AppStrings.sessionExpired.tr());
        return false;
      } else {
        return false;
      }
    } else {
      /// save the new access token
      await _appPreferences.setAccessToken(
          accessTokenValue: refreshEntity?.accessToken ?? Constants.empty);
      return true;
    }
  }

  Future<void> _clearDatabase() async {
    await _appPreferences.clearAppPreferences();
    await DrPurpleDatabase().deleteMyDatabase();
  }
}
