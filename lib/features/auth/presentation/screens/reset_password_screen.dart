import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_app_button.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_back_button.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_password_text_field.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_verification_code_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  double buttonOpacity = 1.0;
  double buttonHeight = AppSize.s20.h;
  double containerOpacity = 0.0;

  int endTime = DateTime.now().millisecond + 1000 * 30;
  late final TextEditingController _newPasswordTextEditingController,
      _reenterPasswordTextEditingController;

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _newPasswordTextEditingController = TextEditingController();
    _reenterPasswordTextEditingController = TextEditingController();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeControllers() {
    _newPasswordTextEditingController.dispose();
    _reenterPasswordTextEditingController.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DrPurpleScaffold(
        backgroundColor: instance<ThemeCubit>().isThemeDark
            ? ColorManager.appBackgroundColorDark
            : ColorManager.white,
        body: _screenContent(context),
      );

  Widget _screenContent(BuildContext context) => Stack(
        children: [
          _resetPasswordDataView(context),
          _backButton(),
        ],
      );

  Widget _resetPasswordDataView(BuildContext context) => Container(
        padding: EdgeInsets.only(top: AppPadding.p3.h),
        height: context.height(),
        decoration:
            boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ..._resetPasswordTitle(),
              DrPurpleVerificationCodeTextField(
                onChange: (val) {},
                itemSize: AppSize.s30.sp,
                length: 6,
              ),
              SizedBox(height: AppSize.s3.h),
              _confirmResetPasswordCode(),
              _newPassword(context),
            ],
          ).paddingAll(AppPadding.p18.sp),
        ),
      );

  Widget _newPassword(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Divider(height: AppSize.s0_5),
            SizedBox(height: AppSize.s4.h),
            Text(
              AppStrings.newPassword.tr(),
              style: getBoldTextStyle(
                color: ColorManager.textPrimaryColor,
                fontSize: FontSize.s20,
              ),
            ),
            SizedBox(height: AppSize.s1.h),
            DrPurplePasswordTextField(
              passwordTextEditingController: _newPasswordTextEditingController,
              formKey: _formKey,
              label: AppStrings.newPasswordTextFieldLabel.tr(),
            ),
            SizedBox(height: AppSize.s2.h),
            DrPurplePasswordTextField(
              passwordTextEditingController:
                  _reenterPasswordTextEditingController,
              formKey: _formKey,
              label: AppStrings.reenterNewPasswordTextFieldLabel.tr(),
            ),
            SizedBox(height: AppSize.s4.h),
            DrPurpleAppButton(
              title: AppStrings.save.tr(),
              onPress: () => context
                ..pop()
                ..pop(),
            ),
          ],
        ).opacity(opacity: containerOpacity),
      );

  Widget _confirmResetPasswordCode() => SizedBox(
        height: buttonHeight,
        child: Column(
          children: [
            _resendCode(),
            SizedBox(height: AppSize.s3.h),
            DrPurpleAppButton(
              title: AppStrings.confirm.tr(),
              onPress: () => setState(() {
                buttonOpacity = 0.0;
                buttonHeight = 0.0;
                containerOpacity = 1.0;
              }),
            ),
          ],
        ),
      ).opacity(opacity: buttonOpacity);

  Widget _resendCode() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                AppStrings.noCodeQuestion.tr(),
                style: getRegularTextStyle(
                  color: ColorManager.textPrimaryColor,
                  fontSize: FontSize.s16,
                ),
              ),
              SizedBox(width: AppSize.s2.w),
              Text(
                AppStrings.resend.tr(),
                style: getBoldTextStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.primary,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const Text("01:58", textAlign: TextAlign.right)
        ],
      );

  List<Widget> _resetPasswordTitle() => [
        SizedBox(height: AppSize.s8.h),
        Text(
          AppStrings.resetPassword.tr(),
          style: getBoldTextStyle(
            fontSize: FontSize.s24,
            color: ColorManager.textPrimaryColor,
          ),
        ),
        SizedBox(height: AppSize.s1.h),
        Text(
          AppStrings.codeDesc.tr(),
          style: getRegularTextStyle(
            color: ColorManager.textSecondaryColor,
            fontSize: FontSize.s14,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSize.s2.h),
      ];

  Widget _backButton() => Positioned(
        top: 30,
        child: DrPurpleBackButton(
          color: instance<ThemeCubit>().isThemeDark
              ? ColorManager.white
              : ColorManager.black,
        ),
      );
}
