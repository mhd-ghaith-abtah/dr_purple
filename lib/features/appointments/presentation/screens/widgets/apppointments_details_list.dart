import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/get_all_appointments_api_response/get_all_appointments_api_response.dart';
import 'package:dr_purple/features/appointments/presentation/blocs/appointments_bloc/appointments_bloc.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_services_api_response/get_all_services_api_response.dart';
import 'package:dr_purple/features/home/presentation/blocs/book_appointment_bloc/book_appointment_bloc.dart';
import 'package:dr_purple/features/settings/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:responsive_sizer/responsive_sizer.dart';

class AppointmentDetailsList extends StatelessWidget {
  const AppointmentDetailsList({
    super.key,
    this.bookAppointmentBloc,
    this.services,
    this.appointmentData,
    this.appointmentsBloc,
  });

  final BookAppointmentBloc? bookAppointmentBloc;
  final List<ServiceModel>? services;
  final AppointmentModel? appointmentData;
  final AppointmentsBloc? appointmentsBloc;

  @override
  Widget build(BuildContext context) {
    if (bookAppointmentBloc == null) {
      return BlocListener<AppointmentsBloc, AppointmentsState>(
        listener: (context, state) async {
          if (state is AppointmentsLoading &&
              state.loadingType ==
                  AppointmentsBlocStateType.cancelAppointment) {
            LoadingOverlay.of(context).show();
          } else if (state is AppointmentsError &&
              state.errorType == AppointmentsBlocStateType.cancelAppointment) {
            LoadingOverlay.of(context).hide();
            await Utils.showToast(state.errorMessage);
          } else if (state is AppointmentsLoaded &&
              state.loadedType == AppointmentsBlocStateType.cancelAppointment) {
            appointmentsBloc!.add(GetMyAppointments());
          } else if (state is AppointmentsLoaded &&
              state.loadedType == AppointmentsBlocStateType.getMyAppointments) {
            LoadingOverlay.of(context).hide();
            context.pop();
            await Utils.showToast(AppStrings.cancelAppointmentSuccess.tr());
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Utils.getImageByServiceName(
                    appointmentData!.serviceTime.contractService.service.name!),
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRect(AppSize.s8),
              SizedBox(height: AppSize.s2.h),
              _mOption(
                  AppStrings.service.tr(), Icons.medical_services_outlined),
              SizedBox(height: AppSize.s1.h),
              Text(
                "${appointmentData!.serviceTime.contractService.service
                    .name!} - ${AppStrings.price.tr(args: [
                  appointmentData!.serviceTime.contractService.service.price
                      .toString()
                ])}",
                style: getRegularTextStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s16,
                ),
              ).paddingLeft(AppPadding.p5.w),
              SizedBox(height: AppSize.s2.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: AppPadding.p0_5.h),
                    decoration: nb.boxDecorationWithRoundedCorners(
                      backgroundColor: ColorManager.cyan,
                      borderRadius: nb.radius(AppSize.s12),
                    ),
                    child: Image.asset(
                      ImageAssets.doctorImage,
                      height: AppSize.s50,
                      width: AppSize.s50,
                    ),
                  ),
                  SizedBox(width: AppSize.s2.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.doctor.tr(),
                        style: getRegularTextStyle(
                          color: instance<ThemeCubit>().isThemeDark
                              ? ColorManager.white
                              : ColorManager.black,
                        ),
                      ),
                      SizedBox(height: AppSize.s1.h),
                      Text(
                        "${appointmentData!.serviceTime.contractService.contract
                            .doctor.firstName} ${appointmentData!.serviceTime
                            .contractService.contract.doctor.lastName}",
                        style: getRegularTextStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: AppSize.s2.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: AppPadding.p0_5.h),
                    decoration: nb.boxDecorationWithRoundedCorners(
                      borderRadius: nb.radius(AppSize.s12),
                      backgroundColor: ColorManager.cyan,
                    ),
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      bloc: instance<ProfileBloc>(),
                      builder: (context, state) {
                        if (instance<ProfileBloc>().getProfileEntity?.gender ==
                            1) {
                          return Image.asset(
                            ImageAssets.maleProfileImage,
                            height: 50,
                            width: 50,
                          );
                        } else if (instance<ProfileBloc>()
                            .getProfileEntity
                            ?.gender ==
                            2) {
                          return Image.asset(
                            ImageAssets.femaleProfileImage,
                            height: 50,
                            width: 50,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: AppSize.s2.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.patient.tr(),
                        style: getRegularTextStyle(
                          color: instance<ThemeCubit>().isThemeDark
                              ? ColorManager.white
                              : ColorManager.black,
                        ),
                      ),
                      SizedBox(height: AppSize.s1.h),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        bloc: instance<ProfileBloc>(),
                        builder: (context, state) {
                          if (instance<ProfileBloc>().getProfileEntity !=
                              null) {
                            return Text(
                              "${instance<ProfileBloc>().getProfileEntity
                                  ?.firstName} ${instance<ProfileBloc>()
                                  .getProfileEntity?.lastName}",
                              style: getRegularTextStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s16,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: AppSize.s2.h),
              _mOption(
                AppStrings.appointmentTime.tr(),
                Icons.watch_later_outlined,
              ),
              SizedBox(height: AppSize.s0_5.h),
              Text(
                Utils.getAppointmentTime(
                  appointmentData!.serviceTime.date,
                  appointmentData!.serviceTime.startTime,
                ),
                style: getRegularTextStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s16,
                ),
              ).paddingLeft(AppPadding.p5.w),
              SizedBox(height: AppSize.s2.h),
              _mOption(
                AppStrings.appointmentState.tr(),
                CupertinoIcons.exclamationmark_circle,
              ),
              SizedBox(height: AppSize.s0_5.h),
              Text(
                Utils.getAppointmentState(appointmentData!.serviceTime.state),
                style: getRegularTextStyle(
                  color: appointmentData!.serviceTime.state ==
                      Constants.bookedServiceTimeState
                      ? ColorManager.primary
                      : appointmentData!.serviceTime.state ==
                      Constants.doneServiceTimeState
                      ? Colors.green
                      : ColorManager.red,
                  fontSize: FontSize.s16,
                ),
              ).paddingLeft(AppPadding.p5.w),
              if(appointmentData!.serviceTime.state !=
                  Constants.doneServiceTimeState)...[
                SizedBox(height: AppSize.s5.h),
                nb.AppButton(
                  height: AppSize.s50,
                  width: context.width(),
                  color: ColorManager.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.cancelAppointment.tr(),
                        style: nb.boldTextStyle(
                          color: instance<ThemeCubit>().isThemeDark
                              ? ColorManager.black
                              : ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () async =>
                  await Utils.dialog(
                    context: context,
                    dialogType: DialogType.warning,
                    okButtonTitle: AppStrings.confirm.tr(),
                    dialogTitle: AppStrings.cancelAppointment.tr(),
                    dialogDesc: AppStrings.cancelAppointmentDialogDesc.tr(),
                    onPressCancel: () {},
                    onPressOk: () =>
                        appointmentsBloc!
                            .add(
                            CancelAppointmentEvent(id: appointmentData!.id)),
                    swapColors: true,
                  ).show(),
                ).paddingOnly(
                  right: AppPadding.p4.w,
                  left: AppPadding.p4.w,
                  bottom: AppPadding.p2.h,
                ),
              ],
              SizedBox(height: AppSize.s2.h),
            ],
          ).paddingAll(AppPadding.p18.sp),
        ),
      );
    } else {
      final service = services!.firstWhere(
            (element) => element.id == bookAppointmentBloc!.selectedServiceId,
      );
      final serviceTimeIndex =
      bookAppointmentBloc!.serviceTimeResponseFiltered.indexWhere(
            (element) =>
        element.id == bookAppointmentBloc!.selectedServiceTimeId,
      );
      final serviceTime =
      bookAppointmentBloc!.serviceTimeResponseFiltered[serviceTimeIndex];
      final doctor = bookAppointmentBloc!.filteredDoctors[serviceTimeIndex];
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Utils.getImageByServiceName(service.name!),
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(AppSize.s8),
            SizedBox(height: AppSize.s2.h),
            const Divider(thickness: AppSize.s0_5),
            SizedBox(height: AppSize.s2.h),
            _mOption(AppStrings.service.tr(), Icons.medical_services_outlined),
            SizedBox(height: AppSize.s1.h),
            Text(
              service.name!,
              style: getRegularTextStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s16,
              ),
            ).paddingLeft(AppPadding.p5.w),
            SizedBox(height: AppSize.s2.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: AppPadding.p0_5.h),
                  decoration: nb.boxDecorationWithRoundedCorners(
                    backgroundColor: ColorManager.cyan,
                    borderRadius: nb.radius(AppSize.s12),
                  ),
                  child: Image.asset(
                    ImageAssets.doctorImage,
                    height: AppSize.s50,
                    width: AppSize.s50,
                  ),
                ),
                SizedBox(width: AppSize.s2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.doctor.tr(),
                      style: getRegularTextStyle(
                        color: instance<ThemeCubit>().isThemeDark
                            ? ColorManager.white
                            : ColorManager.black,
                      ),
                    ),
                    SizedBox(height: AppSize.s1.h),
                    Text(
                      "${doctor.firstName} ${doctor.lastName}",
                      style: getRegularTextStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSize.s2.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: AppPadding.p0_5.h),
                  decoration: nb.boxDecorationWithRoundedCorners(
                    borderRadius: nb.radius(AppSize.s12),
                    backgroundColor: ColorManager.cyan,
                  ),
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    bloc: instance<ProfileBloc>(),
                    builder: (context, state) {
                      if (instance<ProfileBloc>().getProfileEntity?.gender ==
                          1) {
                        return Image.asset(
                          ImageAssets.maleProfileImage,
                          height: 50,
                          width: 50,
                        );
                      } else if (instance<ProfileBloc>()
                          .getProfileEntity
                          ?.gender ==
                          2) {
                        return Image.asset(
                          ImageAssets.femaleProfileImage,
                          height: 50,
                          width: 50,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                SizedBox(width: AppSize.s2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.patient.tr(),
                      style: getRegularTextStyle(
                        color: instance<ThemeCubit>().isThemeDark
                            ? ColorManager.white
                            : ColorManager.black,
                      ),
                    ),
                    SizedBox(height: AppSize.s1.h),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      bloc: instance<ProfileBloc>(),
                      builder: (context, state) {
                        if (instance<ProfileBloc>().getProfileEntity != null) {
                          return Text(
                            "${instance<ProfileBloc>().getProfileEntity
                                ?.firstName} ${instance<ProfileBloc>()
                                .getProfileEntity?.lastName}",
                            style: getRegularTextStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s16,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSize.s2.h),
            _mOption(
              AppStrings.appointmentTime.tr(),
              Icons.watch_later_outlined,
            ),
            SizedBox(height: AppSize.s0_5.h),
            Text(
              Utils.getAppointmentTime(
                serviceTime.date!,
                serviceTime.startTime!,
              ),
              style: getRegularTextStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s16,
              ),
            ).paddingLeft(AppPadding.p5.w),
            SizedBox(height: AppSize.s10.h),
          ],
        ).paddingAll(AppPadding.p18.sp),
      );
    }
  }

  Widget _mOption(var value, IconData icon) =>
      RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child:
              Icon(icon, size: AppSize.s16).paddingRight(AppPadding.p2.w),
            ),
            TextSpan(
              text: value,
              style: getRegularTextStyle(
                fontSize: FontSize.s16,
                color: ColorManager.textSecondaryColor,
              ),
            ),
          ],
        ),
      );
}
