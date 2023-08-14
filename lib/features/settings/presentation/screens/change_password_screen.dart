import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_app_button.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_password_text_field.dart';
import 'package:dr_purple/features/settings/presentation/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final ChangePasswordBloc _changePasswordBloc;

  late final TextEditingController _oldPasswordTextEditingController,
      _newPasswordTextEditingController,
      _repeatNewPasswordTextEditingController;

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _changePasswordBloc = instance<ChangePasswordBloc>();

    _oldPasswordTextEditingController = TextEditingController();
    _newPasswordTextEditingController = TextEditingController();
    _repeatNewPasswordTextEditingController = TextEditingController();

    _oldPasswordTextEditingController.addListener(() => _changePasswordBloc
      ..add(SetOldPassword(_oldPasswordTextEditingController.text))
      ..add(ChangePasswordValidateInputEvent()));

    _newPasswordTextEditingController.addListener(() => _changePasswordBloc
      ..add(SetNewPassword(_newPasswordTextEditingController.text))
      ..add(ChangePasswordValidateInputEvent()));

    _repeatNewPasswordTextEditingController
        .addListener(() => _changePasswordBloc
          ..add(SetRepeatNewPassword(
              _repeatNewPasswordTextEditingController.text))
          ..add(ChangePasswordValidateInputEvent()));
  }

  @override
  initState() {
    super.initState();
    _bind();
  }

  _disposeBloc() async => await _changePasswordBloc.close();

  _disposeControllers() {
    _oldPasswordTextEditingController.dispose();
    _newPasswordTextEditingController.dispose();
    _repeatNewPasswordTextEditingController.dispose();
  }

  @override
  void dispose() {
    _disposeBloc();
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _screenContent();

  Widget _screenContent() => BlocProvider(
        create: (context) => _changePasswordBloc,
        child: _changePasswordScreenContent(),
      );

  Widget _changePasswordScreenContent() =>
      BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) async {
          if (state is ChangePasswordLoading) {
            if (state.loadingType == ChangePasswordBlocStateType.server) {
              LoadingOverlay.of(context).show();
            }
          } else if (state is ChangePasswordLoaded) {
            if (state.loadedType == ChangePasswordBlocStateType.server) {
              LoadingOverlay.of(context).hide();
              context.pop();
              await Utils.showToast(AppStrings.passwordChanged.tr());
            }
          } else if (state is ChangePasswordError) {
            if (state.errorType == ChangePasswordBlocStateType.server) {
              LoadingOverlay.of(context).hide();
            }
            await Utils.showToast(state.errorMessage);
          }
        },
        child: DrPurpleScaffold(
          backgroundColor: instance<ThemeCubit>().isThemeDark
              ? ColorManager.black
              : ColorManager.white,
          appBar: AppBar(
            title: Text(AppStrings.changePassword.tr()),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(AppPadding.p10.sp),
                  decoration: boxDecorationRoundedWithShadow(
                    AppSize.s10.toInt(),
                    backgroundColor: context.cardColor,
                  ),
                  child: Column(
                    children: [
                      DrPurplePasswordTextField(
                        passwordTextEditingController:
                            _oldPasswordTextEditingController,
                        formKey: _formKey,
                        label: AppStrings.currentPassword.tr(),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: AppSize.s2.h),
                      DrPurplePasswordTextField(
                        passwordTextEditingController:
                            _newPasswordTextEditingController,
                        formKey: _formKey,
                        label: AppStrings.newPasswordTextFieldLabel.tr(),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: AppSize.s2.h),
                      DrPurplePasswordTextField(
                        passwordTextEditingController:
                            _repeatNewPasswordTextEditingController,
                        formKey: _formKey,
                        label: AppStrings.repeatNewPassword.tr(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSize.s10.h),
                BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                  builder: (context, state) => DrPurpleAppButton(
                    onPress: _changePasswordBloc.inputsValid
                        ? () =>
                            _changePasswordBloc.add(SendChangePasswordEvent())
                        : () async => await Utils.showToast(
                            AppStrings.missingInfoError.tr()),
                    title: AppStrings.confirm.tr(),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: AppSize.s4.w),
          ),
        ),
      );
}
