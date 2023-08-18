import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/forget_password/forget_password_params.dart';
import 'package:dr_purple/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_event.dart';

part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  String _phoneNumber = Constants.empty;

  bool _inputsValid = false;

  bool get inputsValid => _inputsValid;

  String get phoneNumber => _phoneNumber;

  ForgetPasswordBloc(this._forgetPasswordUseCase)
      : super(ForgetPasswordInitial()) {
    on<SendForgetPasswordEvent>((event, emit) async {
      emit(ForgetPasswordLoading(
          loadingType: ForgetPasswordBlocStateType.server));
      String errorMessage = Constants.empty;
      var res = await _forgetPasswordUseCase.call(
        ForgetPasswordParams(
            body: ForgetPasswordParamsBody(mobileNumber: _phoneNumber)),
      );
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) => false);

      ///if there is an error occurred during API Request, emit error state
      if (isError) {
        emit(ForgetPasswordError(
            errorMessage: errorMessage,
            errorType: ForgetPasswordBlocStateType.server));
      } else {
        emit(ForgetPasswordLoaded(
            loadedType: ForgetPasswordBlocStateType.server));
      }
    });
    on<SetForgetPasswordPhoneNumber>((event, emit) {
      _phoneNumber = event.phoneNumber;
    });

    on<ForgetPasswordValidateInputEvent>((event, emit) {
      _inputsValid = Utils.isPhoneNumberValid(_phoneNumber);
      emit(ForgetPasswordLoaded(
          loadedType: ForgetPasswordBlocStateType.validateInput));
    });
  }
}
