import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DrPurpleNameTextField extends StatelessWidget {
  const DrPurpleNameTextField({
    Key? key,
    required this.label,
    required this.nameTextEditingController,
    required this.formKey,
    required this.errorMessage,
    this.readOnly,
    this.fontSize,
  }) : super(key: key);

  final String label;
  final String errorMessage;
  final bool? readOnly;
  final double? fontSize;
  final TextEditingController nameTextEditingController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) => AppTextField(
        controller: nameTextEditingController,
        textFieldType: TextFieldType.NAME,
        textInputAction: TextInputAction.next,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: getRegularTextStyle(
            fontSize: fontSize ?? FontSize.s14,
            color: ColorManager.textSecondaryColor,
          ),
          errorMaxLines: 2,
          prefixIcon: Icon(
            Icons.person_outline,
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
        onTap: () => formKey.currentState?.validate(),
        onChanged: (_) => formKey.currentState?.validate(),
        validator: (value) =>
            value == null || Utils.isNameValid(value) || value.isEmpty
                ? null
                : errorMessage,
      );
}
