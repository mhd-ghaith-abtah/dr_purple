import 'package:dr_purple/app/storage/app_preferences.dart';
import 'package:dr_purple/app/storage/database/dr_purple_database.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/logout/logout_params.dart';
import 'package:dr_purple/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase _logoutUseCase;
  final AppPreferences _appPreferences;

  LogoutCubit(this._logoutUseCase, this._appPreferences)
      : super(LogoutInitial());

  Future<void> logout() async {
    emit(LoggingOut());
    String errorMessage = Constants.empty;
    final res =
        await _logoutUseCase.call(LogoutParams(body: LogoutParamsBody()));
    bool isError = res.fold((l) {
      errorMessage = l.message;
      return true;
    }, (r) {
      return false;
    });
    if (isError) {
      emit(LogoutError(errorMessage: errorMessage));
    } else {
      await _appPreferences.clearAppPreferences();
      await DrPurpleDatabase().deleteMyDatabase();
      emit(LoggedOut());
    }
  }
}
