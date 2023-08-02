import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/app/storage/app_preferences.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_account/verify_account_params.dart';
import 'package:dr_purple/features/auth/domain/entities/verify_account_entity.dart';
import 'package:dr_purple/features/auth/domain/use_cases/verify_account_use_case.dart';
import 'package:dr_purple/features/settings/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_account_event.dart';

part 'verify_account_state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  final VerifyAccountUseCase _verifyAccountUseCase;
  final AppPreferences _appPreferences;

  String _code = Constants.empty;
  bool _inputValid = false;

  bool get inputValid => _inputValid;

  VerifyAccountBloc(this._verifyAccountUseCase, this._appPreferences)
      : super(VerifyAccountInitial()) {
    on<SetVerificationCode>((event, emit) async {
      _code = event.code;
      _inputValid = event.code.length == 6;
      emit(VerifyAccountLoaded(loadedType: VerifyAccountBlocStateType.setCode));
    });

    on<VerifyUserAccount>((event, emit) async {
      emit(
          VerifyAccountLoading(loadingType: VerifyAccountBlocStateType.server));
      String errorMessage = Constants.empty;
      VerifyAccountEntity? verifyAccountResponse;
      var res = await _verifyAccountUseCase.call(
        VerifyAccountParams(
            body: VerifyAccountParamsBody(
                contactNumber: _appPreferences.getUserInfo())),
      );
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        verifyAccountResponse = r;
        return false;
      });

      ///if there is an error occurred during API Request, emit error state
      if (isError) {
        emit(VerifyAccountError(
          errorMessage: errorMessage,
          errorType: VerifyAccountBlocStateType.server,
        ));
      } else {
        await _appPreferences.removeLastRoute();
        await _appPreferences.removeUserInfo();

        await _appPreferences.setAccessToken(
          accessTokenValue:
              verifyAccountResponse?.accessToken ?? Constants.empty,
        );
        await _appPreferences.setRefreshToken(
          refreshTokenValue:
              verifyAccountResponse?.refreshToken ?? Constants.empty,
        );
        emit(
            VerifyAccountLoaded(loadedType: VerifyAccountBlocStateType.server));
        instance<ProfileBloc>().add(GetProfile());
      }
    });
  }
}
