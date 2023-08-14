import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/settings/data/models/params/change_password/change_password_params.dart';
import 'package:dr_purple/features/settings/domain/use_cases/change_password_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  String _oldPassword = Constants.empty,
      _newPassword = Constants.empty,
      _repeatNewPassword = Constants.empty;

  bool _inputsValid = false;

  bool get inputsValid => _inputsValid;

  ChangePasswordBloc(this._changePasswordUseCase)
      : super(ChangePasswordInitial()) {
    on<SendChangePasswordEvent>((event, emit) async {
      emit(ChangePasswordLoading(
          loadingType: ChangePasswordBlocStateType.server));
      String errorMessage = Constants.empty;
      var res = await _changePasswordUseCase.call(
        ChangePasswordParams(
            body: ChangePasswordParamsBody(
          oldPassword: _oldPassword,
          newPassword: _newPassword,
        )),
      );
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) => false);

      ///if there is an error occurred during API Request, emit error state
      if (isError) {
        emit(ChangePasswordError(
          errorMessage: errorMessage,
          errorType: ChangePasswordBlocStateType.server,
        ));
      } else {
        emit(ChangePasswordLoaded(
            loadedType: ChangePasswordBlocStateType.server));
      }
    });

    on<SetOldPassword>((event, emit) async {
      _oldPassword = event.oldPassword;
    });

    on<SetNewPassword>((event, emit) async {
      _newPassword = event.newPassword;
    });

    on<SetRepeatNewPassword>((event, emit) async {
      _repeatNewPassword = event.repeatNewPassword;
    });

    on<ChangePasswordValidateInputEvent>((event, emit) {
      _inputsValid = Utils.isPasswordValid(_newPassword) &&
          Utils.isPasswordValid(_oldPassword) &&
          (_repeatNewPassword == _newPassword);
      emit(ChangePasswordLoaded(
          loadedType: ChangePasswordBlocStateType.validateInput));
    });
  }
}
