import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_forget_password/verify_forget_password_params.dart';
import 'package:dr_purple/features/auth/domain/use_cases/verify_forget_password_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_forget_password_event.dart';

part 'verify_forget_password_state.dart';

class VerifyForgetPasswordBloc
    extends Bloc<VerifyForgetPasswordEvent, VerifyForgetPasswordState> {
  final VerifyForgetPasswordUseCase _verifyForgetPasswordUseCase;

  String _code = Constants.empty,
      _newPassword = Constants.empty,
      _repeatNewPassword = Constants.empty;

  bool _codeValid = false;

  bool get codeValid => _codeValid;
  bool _passwordsValid = false;

  bool get passwordsValid => _passwordsValid;

  VerifyForgetPasswordBloc(this._verifyForgetPasswordUseCase)
      : super(VerifyForgetPasswordInitial()) {
    on<SendVerifyForgetPasswordEvent>((event, emit) async {
      emit(VerifyForgetPasswordLoading(
          loadingType: VerifyForgetPasswordBlocStateType.server));
      String errorMessage = Constants.empty;
      var res = await _verifyForgetPasswordUseCase.call(
        VerifyForgetPasswordParams(
            body: VerifyForgetPasswordParamsBody(
          mobileNumber: event.phoneNumber,
          code: _code,
          newPassword: _newPassword,
        )),
      );
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) => false);

      ///if there is an error occurred during API Request, emit error state
      if (isError) {
        emit(VerifyForgetPasswordError(
          errorMessage: errorMessage,
          errorType: VerifyForgetPasswordBlocStateType.server,
        ));
      } else {
        emit(VerifyForgetPasswordLoaded(
            loadedType: VerifyForgetPasswordBlocStateType.server));
      }
    });

    on<SetVerifyForgetPasswordCode>((event, emit) async {
      _code = event.code;
      _codeValid = (_code.length == 6);
      emit(VerifyForgetPasswordLoaded(
          loadedType: VerifyForgetPasswordBlocStateType.validateInput));
    });

    on<SetVerifyForgetPasswordNewPassword>((event, emit) async {
      _newPassword = event.newPassword;
    });

    on<SetVerifyForgetPasswordRepeatNewPassword>((event, emit) async {
      _repeatNewPassword = event.newPasswordRepeat;
    });

    on<VerifyForgetPasswordValidateInputEvent>((event, emit) {
      _passwordsValid = Utils.isPasswordValid(_newPassword) &&
          (_repeatNewPassword == _newPassword);
      emit(VerifyForgetPasswordLoaded(
          loadedType: VerifyForgetPasswordBlocStateType.validateInput));
    });
  }
}
