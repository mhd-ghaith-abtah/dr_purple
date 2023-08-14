import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DrPurplePasswordTextField extends StatelessWidget {
  const DrPurplePasswordTextField({
    Key? key,
    required this.passwordTextEditingController,
    required this.formKey,
    this.label,
    this.textInputAction,
  }) : super(key: key);

  final TextEditingController passwordTextEditingController;
  final TextInputAction? textInputAction;
  final GlobalKey<FormState> formKey;
  final String? label;

  @override
  Widget build(BuildContext context) => AppTextField(
      controller: passwordTextEditingController,
      textInputAction: textInputAction ?? TextInputAction.done,
      textFieldType: TextFieldType.PASSWORD,
      isPassword: true,
      suffixPasswordInvisibleWidget: Icon(
        Icons.visibility_off,
        color: instance<ThemeCubit>().isThemeDark
            ? ColorManager.primary
            : Theme.of(context).iconTheme.color,
      ),
      suffixPasswordVisibleWidget: Icon(
        Icons.visibility,
        color: instance<ThemeCubit>().isThemeDark
            ? Theme.of(context).iconTheme.color
            : ColorManager.primary,
      ),
      decoration: InputDecoration(
        labelText: label ?? AppStrings.passwordTextFieldLabel.tr(),
        labelStyle: getRegularTextStyle(
          fontSize: FontSize.s16,
          color: ColorManager.textSecondaryColor,
        ),
        errorMaxLines: 2,
        prefixIcon: Icon(
          Icons.lock_outline,
          color: instance<ThemeCubit>().isThemeDark
              ? ColorManager.white
              : ColorManager.black,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.lightGrey.withOpacity(0.2),
          ),
        ),
      ),
      //  onTap: () => formKey.currentState?.validate(),
      // onChanged: (_) => formKey.currentState?.validate(),
      validator: (value) =>
          // value == null || Utils.isPasswordValid(value) || value.isEmpty
          //    ?
          null
      //  : AppStrings.passwordError.tr(),
      );
}
