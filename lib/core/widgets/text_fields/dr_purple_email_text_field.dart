import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DrPurpleEmailTextField extends StatelessWidget {
  const DrPurpleEmailTextField({
    Key? key,
    required this.emailTextEditingController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController emailTextEditingController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) => AppTextField(
        controller: emailTextEditingController,
        textFieldType: TextFieldType.EMAIL,
        decoration: InputDecoration(
          labelText: AppStrings.emailTextFieldLabel.tr(),
          labelStyle: getRegularTextStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondaryColor,
          ),
          errorMaxLines: 2,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: instance<ThemeCubit>().isThemeDark
                ? ColorManager.white
                : ColorManager.black,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.lightGrey.withOpacity(0.2),
              width: AppSize.s1,
            ),
          ),
        ),
        onTap: () => formKey.currentState?.validate(),
        onChanged: (_) => formKey.currentState?.validate(),
        validator: (value) =>
            value == null || Utils.isEmailValid(value) || value.isEmpty
                ? null
                : AppStrings.emailError.tr(),
      );
}
