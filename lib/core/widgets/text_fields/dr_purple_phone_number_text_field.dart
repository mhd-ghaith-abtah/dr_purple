import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/country_code_picker/src/fl_country_code_picker.dart';
import 'package:dr_purple/features/auth/presentation/bloc/country_code_cubit/country_code_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurplePhoneNumberTextField extends StatelessWidget {
  const DrPurplePhoneNumberTextField({
    Key? key,
    required this.phoneNumberTextEditingController,
    required this.formKey,
    required this.countryCodeCubit,
    required this.countryPicker,
    this.textInputAction,
  }) : super(key: key);

  final TextEditingController phoneNumberTextEditingController;
  final GlobalKey<FormState> formKey;
  final CountryCodeCubit countryCodeCubit;
  final FlCountryCodePicker countryPicker;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) => AppTextField(
        textFieldType: TextFieldType.PHONE,
        textInputAction: textInputAction ?? TextInputAction.next,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: phoneNumberTextEditingController,
        decoration: InputDecoration(
          labelText: AppStrings.phoneNumberTextFieldLabel.tr(),
          labelStyle: getRegularTextStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.lightGrey.withOpacity(0.2),
            ),
          ),
          prefixIcon: GestureDetector(
            onTap: () async => await countryPicker
                .showPicker(context: context, pickerMaxHeight: 30.h)
                .then((code) => countryCodeCubit.changeCountryCode(
                      code ?? countryCodeCubit.countryCode,
                    )),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppPadding.p2.w,
                vertical: AppPadding.p0_5.h,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p1.w,
                vertical: AppPadding.p0_5.h,
              ),
              color: instance<ThemeCubit>().isThemeDark
                  ? ColorManager.appSecondaryBackgroundColor
                  : ColorManager.white,
              child: BlocBuilder<CountryCodeCubit, CountryCodeState>(
                builder: (context, state) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    countryCodeCubit.countryCode.flagImage,
                    SizedBox(width: AppSize.s1.w),
                    Text(
                      countryCodeCubit.countryCode.dialCode,
                      style: getRegularTextStyle(
                        color: ColorManager.textPrimaryColor,
                        fontSize: FontSize.s16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        onTap: () => formKey.currentState?.validate(),
        onChanged: (_) => formKey.currentState?.validate(),
        validator: (value) =>
            value == null || Utils.isPhoneNumberValid(value) || value.isEmpty
                ? null
                : AppStrings.phoneNumberError.tr(),
      );
}
