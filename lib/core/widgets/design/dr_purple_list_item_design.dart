import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurpleListItemDesign extends StatelessWidget {
  const DrPurpleListItemDesign({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.showAnotherPageIcon = true,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function() onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool showAnotherPageIcon;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: AppPadding.p2.h),
        padding: EdgeInsets.all(AppPadding.p14.sp),
        decoration: boxDecorationRoundedWithShadow(
          AppSize.s10.toInt(),
          backgroundColor: context.cardColor,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppSize.s24,
              color: iconColor ??
                  (instance<ThemeCubit>().isThemeDark
                      ? ColorManager.black
                      : Colors.blue),
            ),
            SizedBox(width: AppSize.s2.w),
            Text(
              title,
              style: getRegularTextStyle(
                color: textColor ?? ColorManager.textPrimaryColor,
                fontSize: FontSize.s16,
              ),
            ).expand(),
            if (showAnotherPageIcon)
              Icon(
                Icons.arrow_forward_ios,
                color: instance<ThemeCubit>().isThemeDark
                    ? ColorManager.black
                    : Colors.grey,
                size: AppSize.s16,
              ),
          ],
        ),
      ).onTap(onTap);
}
