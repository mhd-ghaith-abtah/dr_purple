import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/app/dummy_test_data/dummy_test_data.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurpleNotificationListItemDesign extends StatelessWidget {
  const DrPurpleNotificationListItemDesign(
      {Key? key, required this.notificationData})
      : super(key: key);

  final NotificationData notificationData;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: AppPadding.p1.h),
        padding: EdgeInsets.all(AppPadding.p18.sp),
        decoration: boxDecorationRoundedWithShadow(
          AppSize.s10.toInt(),
          backgroundColor:
              instance<ThemeCubit>().isThemeDark ? scaffoldDarkColor : white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: AppSize.s8.h,
              width: AppSize.s16.w,
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: instance<ThemeCubit>().isThemeDark
                    ? scaffoldDarkColor
                    : Colors.grey.shade50,
                borderRadius: radius(AppSize.s10),
              ),
              child: notificationData.image,
            ),
            SizedBox(width: AppSize.s2.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationData.title,
                  style: getRegularTextStyle(
                    fontSize: FontSize.s14,
                    color: instance<ThemeCubit>().isThemeDark
                        ? ColorManager.white
                        : ColorManager.black,
                  ),
                ),
                SizedBox(height: AppSize.s1.h),
                Row(
                  children: [
                    Text(
                      notificationData.time,
                      style: getBoldTextStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.primary,
                      ),
                    ).expand(),
                  ],
                ),
              ],
            ).expand(),
          ],
        ),
      );
}
