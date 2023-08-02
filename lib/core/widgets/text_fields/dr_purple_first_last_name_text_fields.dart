import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_name_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurpleFirstLastNameTextFields extends StatelessWidget {
  const DrPurpleFirstLastNameTextFields({
    Key? key,
    required this.firstNameTextEditingController,
    required this.lastNameTextEditingController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController firstNameTextEditingController;
  final TextEditingController lastNameTextEditingController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          DrPurpleNameTextField(
            label: AppStrings.firstNameTextFieldLabel.tr(),
            nameTextEditingController: firstNameTextEditingController,
            formKey: formKey,
            errorMessage: AppStrings.firstNameError.tr(),
          ).expand(),
          SizedBox(width: AppSize.s2.w),
          DrPurpleNameTextField(
            label: AppStrings.lastNameTextFieldLabel.tr(),
            nameTextEditingController: lastNameTextEditingController,
            formKey: formKey,
            errorMessage: AppStrings.lastNameError.tr(),
          ).expand(),
        ],
      );
}
