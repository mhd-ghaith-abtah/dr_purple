import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/app/storage/app_preferences.dart';
import 'package:dr_purple/core/freezed_data_classes/login_object/login_object.dart';
import 'package:dr_purple/core/services/firebase_messaeging_service.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/login/login_params.dart';
import 'package:dr_purple/features/auth/domain/entities/login_entity.dart';
import 'package:dr_purple/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dr_purple/features/notifications/data/remote/models/params/update_fcm_token_params/update_fcm_token_params.dart';
import 'package:dr_purple/features/notifications/domain/use_cases/update_fcm_token_use_case.dart';
import 'package:dr_purple/features/settings/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final UpdateFCMTokenUseCase _updateFCMTokenUseCase;
  final AppPreferences _appPreferences;

  LoginObject _loginObject = LoginObject(Constants.empty, Constants.empty);

  bool _inputsValid = false;

  bool get inputsValid => _inputsValid;

  LoginBloc(
    this._loginUseCase,
    this._appPreferences,
    this._updateFCMTokenUseCase,
  ) : super(LoginInitial()) {
    on<LogUserInEvent>((event, emit) async {
      emit(LoginLoading(loadingType: LoginBlocStateType.server));
      String errorMessage = Constants.empty;
      LoginEntity? loginResponse;
      var res = await _loginUseCase.call(
        LoginParams(
          body: LoginParamsBody(
            userName: _loginObject.userName,
            password: _loginObject.password,
          ),
        ),
      );
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        loginResponse = r;
        return false;
      });

      ///if there is an error occurred during API Request, emit error state
      if (isError) {
        emit(LoginError(
            errorMessage: errorMessage, errorType: LoginBlocStateType.server));
      } else {
        await _appPreferences.setAccessToken(
          accessTokenValue: loginResponse?.accessToken ?? Constants.empty,
        );
        await _appPreferences.setRefreshToken(
          refreshTokenValue: loginResponse?.refreshToken ?? Constants.empty,
        );

        final token = await FirebaseMessagingService().getFCMToken();
        if (kDebugMode) {
          print(token);
        }
        String accessToken = Constants.empty;
        var fcmUpdateRes = await _updateFCMTokenUseCase.call(
            UpdateFCMTokenParams(
                body: UpdateFCMTokenParamsBody(fcmKey: token)));
        isError = fcmUpdateRes.fold((l) => true, (r) {
          accessToken = r.accessToken;
          return false;
        });
        await _appPreferences.setAccessToken(accessTokenValue: accessToken);
        emit(LoginLoaded(loadedType: LoginBlocStateType.server));

        instance<ProfileBloc>().add(GetProfile());
      }
    });

    on<SetLoginPassword>((event, emit) {
      _loginObject = _loginObject.copyWith(password: event.password);
    });

    on<SetLoginUsername>((event, emit) {
      _loginObject = _loginObject.copyWith(userName: event.username);
    });

    on<LoginValidateInputEvent>((event, emit) {
      _inputsValid = Utils.isPhoneNumberValid(_loginObject.userName);
      emit(LoginLoaded(loadedType: LoginBlocStateType.validateInput));
    });
  }
}
