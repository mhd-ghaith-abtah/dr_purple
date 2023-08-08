import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/app/dummy_test_data/dummy_test_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurpleAppointmentListItemDesign extends StatelessWidget {
  const DrPurpleAppointmentListItemDesign(
      {Key? key, required this.appointmentData})
      : super(key: key);

  final AppointmentData appointmentData;

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            margin: EdgeInsets.only(top: AppPadding.p1.h),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: instance<ThemeCubit>().isThemeDark
                  ? scaffoldDarkColor
                  : Colors.grey.shade50,
              borderRadius: radius(AppSize.s32),
            ),
            child: Column(
              children: [
                SizedBox(height: AppSize.s3.h),
                Row(
                  children: [
                    Container(
                      height: AppSize.s8.h,
                      width: AppSize.s19.w,
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: ColorManager.primary,
                        borderRadius: radius(AppSize.s12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appointmentData.date,
                            style: getBoldTextStyle(
                              fontSize: FontSize.s20,
                              color: ColorManager.white,
                            ),
                          ),
                          Text(
                            appointmentData.month,
                            style: getRegularTextStyle(
                              fontSize: FontSize.s14,
                              color: ColorManager.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSize.s2.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointmentData.department,
                              style: getBoldTextStyle(
                                fontSize: FontSize.s18,
                                color: ColorManager.textPrimaryColor,
                              ),
                            ),
                            SizedBox(height: AppSize.s1.h),
                            Text(
                              appointmentData.doctor,
                              style: getRegularTextStyle(
                                color: ColorManager.textSecondaryColor,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            SizedBox(height: AppSize.s1.h),
                            Text(
                              'Patient: ${appointmentData.patient}',
                              style: getRegularTextStyle(
                                color: ColorManager.textSecondaryColor,
                                fontSize: FontSize.s14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(AppPadding.p10.sp),
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: Colors.transparent,
                            borderRadius: radius(AppSize.s30),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                          child: Icon(
                            Icons.notifications_none,
                            color: appointmentData.department == 'General Care'
                                ? ColorManager.primary
                                : Colors.grey.shade400,
                            size: AppSize.s24,
                          ),
                        ).paddingBottom(AppPadding.p18.sp)
                      ],
                    ).expand(),
                  ],
                ).paddingSymmetric(horizontal: AppPadding.p18.sp),
                SizedBox(height: AppSize.s1.h),
                const Divider(thickness: AppSize.s0_5),
                SizedBox(height: AppSize.s1.h),
                Row(
                  children: [
                    Text(
                      "9:30 AM",
                      style: getBoldTextStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.primary,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                            padding: const EdgeInsets.all(AppPadding.p10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  AppStrings.appointmentDetails.tr(),
                                  style: getRegularTextStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                                SizedBox(width: AppSize.s1.w),
                                Icon(
                                  Icons.arrow_forward,
                                  color: ColorManager.primary,
                                  size: AppSize.s16,
                                ),
                              ],
                            ))
                        .onTap(() => context.push(
                            "/${Routes.appointmentsRoute}/${Routes.appointmentDetailsRoute}")),
                  ],
                ).paddingSymmetric(horizontal: AppPadding.p18.sp),
                SizedBox(height: AppSize.s2.h),
              ],
            ),
          ).paddingBottom(AppPadding.p4.w),
          Positioned(
            left: AppSize.s16,
            child: Container(
              padding: EdgeInsets.all(AppPadding.p8.sp),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: ColorManager.primary,
                borderRadius: radius(AppSize.s20),
              ),
              child: Text(
                appointmentData.service,
                style: getMediumTextStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s14,
                ),
              ).paddingSymmetric(horizontal: AppPadding.p10.sp),
            ),
          ),
        ],
      );
}
