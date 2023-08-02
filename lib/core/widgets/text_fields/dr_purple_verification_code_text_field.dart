import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurpleVerificationCodeTextField extends StatelessWidget {
  final ValueChanged<String> onChange;
  final int length;
  final double itemSize;

  const DrPurpleVerificationCodeTextField({
    Key? key,
    required this.onChange,
    required this.length,
    required this.itemSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Pinput(
        length: length,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.digitsOnly
        ],
        pinAnimationType: PinAnimationType.fade,
        defaultPinTheme: PinTheme(
          width: itemSize,
          height: itemSize,
          margin: EdgeInsets.all(AppPadding.p8.sp),
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: instance<ThemeCubit>().isThemeDark
                    ? ColorManager.black
                    : ColorManager.white,
              ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSize.s5),
            ),
            border: Border.all(
              color: instance<ThemeCubit>().isThemeDark
                  ? ColorManager.white
                  : ColorManager.primary,
              width: AppSize.s0_5.w,
            ),
          ),
        ),
        focusedPinTheme: PinTheme(
          width: itemSize,
          height: itemSize,
          margin: EdgeInsets.all(AppPadding.p8.sp),
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: instance<ThemeCubit>().isThemeDark
                    ? ColorManager.black
                    : ColorManager.white,
              ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSize.s5),
            ),
            border: Border.all(
              color: instance<ThemeCubit>().isThemeDark
                  ? ColorManager.white
                  : ColorManager.primary,
              width: AppSize.s0_5.w,
            ),
            color: instance<ThemeCubit>().isThemeDark
                ? ColorManager.white
                : ColorManager.primary,
          ),
        ),
        submittedPinTheme: PinTheme(
          width: itemSize,
          height: itemSize,
          margin: EdgeInsets.all(AppPadding.p8.sp),
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: instance<ThemeCubit>().isThemeDark
                    ? ColorManager.black
                    : ColorManager.white,
              ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSize.s5),
            ),
            border: Border.all(
              color: instance<ThemeCubit>().isThemeDark
                  ? ColorManager.primary
                  : ColorManager.white,
              width: AppSize.s0_5.w,
            ),
            color: instance<ThemeCubit>().isThemeDark
                ? ColorManager.white
                : ColorManager.primary,
          ),
        ),
        onChanged: onChange,
      );
}
