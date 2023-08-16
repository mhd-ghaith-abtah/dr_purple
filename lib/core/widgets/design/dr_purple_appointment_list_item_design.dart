import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/get_all_appointments_api_response/get_all_appointments_api_response.dart';
import 'package:dr_purple/features/appointments/presentation/blocs/appointments_bloc/appointments_bloc.dart';
import 'package:dr_purple/features/settings/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurpleAppointmentListItemDesign extends StatelessWidget {
  const DrPurpleAppointmentListItemDesign(
      {Key? key, required this.appointmentData, required this.appointmentsBloc})
      : super(key: key);

  final AppointmentModel appointmentData;
  final AppointmentsBloc appointmentsBloc;

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
                            Utils.getDay(appointmentData.serviceTime.date),
                            style: getBoldTextStyle(
                              fontSize: FontSize.s20,
                              color: ColorManager.white,
                            ),
                          ),
                          Text(
                            Utils.getMonthName(
                                appointmentData.serviceTime.date),
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
                              AppStrings.cosmetology.tr(),
                              style: getBoldTextStyle(
                                fontSize: FontSize.s18,
                                color: ColorManager.textPrimaryColor,
                              ),
                            ),
                            SizedBox(height: AppSize.s1.h),
                            Text(
                              "Dr. ${appointmentData.serviceTime.contractService.contract.doctor.firstName} ${appointmentData.serviceTime.contractService.contract.doctor.lastName}",
                              style: getRegularTextStyle(
                                color: ColorManager.textSecondaryColor,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            SizedBox(height: AppSize.s1.h),
                            Text(
                              "${instance<ProfileBloc>().getProfileEntity?.firstName} ${instance<ProfileBloc>().getProfileEntity?.lastName}",
                              style: getRegularTextStyle(
                                color: ColorManager.textSecondaryColor,
                                fontSize: FontSize.s14,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          Utils.getImageByServiceName(appointmentData
                              .serviceTime.contractService.service.name!),
                          height: 80,
                          width: 100,
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.hue,
                        )
                            .cornerRadiusWithClipRRect(AppSize.s12)
                            .paddingAll(AppPadding.p5.sp)
                      ],
                    ).expand(),
                  ],
                ).paddingSymmetric(horizontal: AppPadding.p18.sp),
                SizedBox(height: AppSize.s1.h),
                const Divider(thickness: AppSize.s0_5),
                SizedBox(height: AppSize.s1.h),
                Text(
                  AppStrings.bookedOn.tr(args: [
                    Utils.getAppointmentBookTime(appointmentData.dateCreated)
                  ]),
                  style: getRegularTextStyle(
                    color: ColorManager.textPrimaryColor,
                    fontSize: FontSize.s14,
                  ),
                ),
                SizedBox(height: AppSize.s1.h),
                Text(
                  Utils.getAppointmentState(appointmentData.serviceTime.state),
                  style: getRegularTextStyle(
                    color: appointmentData.serviceTime.state ==
                            Constants.bookedServiceTimeState
                        ? ColorManager.primary
                        : appointmentData.serviceTime.state ==
                                Constants.doneServiceTimeState
                            ? Colors.green
                            : ColorManager.red,
                    fontSize: FontSize.s14,
                  ),
                ),
                SizedBox(height: AppSize.s1.h),
                Row(
                  children: [
                    Text(
                      Utils.getAppointmentTimeWithoutDate(
                          appointmentData.serviceTime.startTime),
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
                        )).onTap(
                      () => context.push(
                        "${Routes.appointmentsRoute}/${Routes.appointmentDetailsRoute}",
                        extra: {
                          "appointmentData": appointmentData,
                          "bloc": appointmentsBloc,
                        },
                      ),
                    ),
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
                appointmentData.serviceTime.contractService.service.name!,
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
