import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/home/presentation/blocs/book_appointment_bloc/book_appointment_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentTimeComponent extends StatefulWidget {
  const AppointmentTimeComponent({
    super.key,
    required this.bookAppointmentBloc,
  });

  final BookAppointmentBloc bookAppointmentBloc;

  @override
  State<AppointmentTimeComponent> createState() =>
      _AppointmentTimeComponentState();
}

class _AppointmentTimeComponentState extends State<AppointmentTimeComponent> {
  String? selectedTime;

  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    if (today != day) {
      widget.bookAppointmentBloc.add(FilterServiceTimeByDay(selectedDay: day));
      setState(() {
        today = day;
      });
    }
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.appointmentTime.tr(),
                      style: getBoldTextStyle(
                        fontSize: FontSize.s24,
                        color: ColorManager.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: AppSize.s1.h),
                    Text(
                      AppStrings.appointmentTimeDesc.tr(),
                      style: getRegularTextStyle(
                        color: ColorManager.textSecondaryColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                    SizedBox(height: AppSize.s1.h),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: AppPadding.p4.w),
            TableCalendar(
              calendarFormat: CalendarFormat.twoWeeks,
              weekendDays: const [DateTime.friday, DateTime.saturday],
              locale: instance<LanguageManager>().locale.toString(),
              focusedDay: today,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day + 30,
              ),
              selectedDayPredicate: (day) => isSameDay(day, today),
              availableGestures: AvailableGestures.horizontalSwipe,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              onDaySelected: _onDaySelected,
            ),
            BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
              builder: (context, state) {
                if (state is BookAppointmentLoading &&
                    (state.loadingType ==
                            BookAppointmentBlocStateType.filterServiceTimes ||
                        state.loadingType ==
                            BookAppointmentBlocStateType.getServiceTimes)) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 75),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: SizedBox(
                          width: AppSize.s90.w,
                          height: 125.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  width: AppSize.s90.w,
                                  height: 125.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: AppPadding.p8),
                                  padding: const EdgeInsets.all(AppPadding.p5),
                                  decoration: boxDecorationWithRoundedCorners(
                                    borderRadius: radius(AppSize.s12),
                                    border: Border.all(
                                      color: ColorManager.primary,
                                    ),
                                    backgroundColor: ColorManager.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).cornerRadiusWithClipRRectOnly(
                        topLeft: AppSize.s8.toInt(),
                        topRight: AppSize.s8.toInt(),
                      );
                    },
                  ).paddingAll(AppPadding.p18.sp);
                } else {
                  if (widget.bookAppointmentBloc.serviceTimeResponseFiltered
                      .isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        bottom: 75,
                        left: AppPadding.p12,
                        right: AppPadding.p12,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.bookAppointmentBloc
                          .serviceTimeResponseFiltered.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: AppPadding.p8),
                          padding: const EdgeInsets.all(AppPadding.p12),
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: radius(AppSize.s12),
                            border: Border.all(
                              color: widget.bookAppointmentBloc
                                          .selectedServiceTimeId ==
                                      widget.bookAppointmentBloc
                                          .serviceTimeResponseFiltered[index].id
                                  ? ColorManager.primary
                                  : ColorManager.lightGrey100,
                            ),
                            backgroundColor: context.cardColor,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: AppPadding.p4),
                                    height: AppSize.s65,
                                    width: AppSize.s65,
                                    decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: ColorManager.cyan,
                                      borderRadius: radius(AppSize.s12),
                                    ),
                                    child: Image.asset(
                                      ImageAssets.doctorImage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(width: AppSize.s2.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.bookAppointmentBloc.filteredDoctors[index].firstName} ${widget.bookAppointmentBloc.filteredDoctors[index].lastName}",
                                        style: getBoldTextStyle(
                                          fontSize: FontSize.s18,
                                          color: ColorManager.textPrimaryColor,
                                        ),
                                      ),
                                      SizedBox(height: AppSize.s1.h),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: AppSize.s2.h),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.watch_later_outlined,
                                    color: Colors.grey,
                                    size: AppSize.s16,
                                  ),
                                  SizedBox(width: AppSize.s2.w),
                                  Text(
                                    AppStrings.appointmentTimeDots.tr(),
                                    style: getRegularTextStyle(
                                      color: ColorManager.textSecondaryColor,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                  Text(
                                    Utils.getAppointmentTime(
                                        widget
                                            .bookAppointmentBloc
                                            .serviceTimeResponseFiltered[index]
                                            .date!,
                                        widget
                                            .bookAppointmentBloc
                                            .serviceTimeResponseFiltered[index]
                                            .startTime!),
                                    style: getBoldTextStyle(
                                      fontSize: FontSize.s14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  SizedBox(width: AppSize.s2.w),
                                ],
                              ),
                            ],
                          ),
                        ).onTap(
                          () => widget.bookAppointmentBloc.add(
                            SelectServiceTime(
                              serviceTimeId: widget.bookAppointmentBloc
                                  .serviceTimeResponseFiltered[index].id!,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: AppSize.s6.h),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: AppPadding.p8),
                          padding: const EdgeInsets.all(AppPadding.p12),
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: radius(AppSize.s12),
                            border: Border.all(color: ColorManager.primary),
                            backgroundColor: context.cardColor,
                          ),
                          child: Text(
                            AppStrings.appointmentTimeEmpty.tr(),
                            style: getBoldTextStyle(
                              color: ColorManager.textPrimaryColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ],
        ),
      );
}
