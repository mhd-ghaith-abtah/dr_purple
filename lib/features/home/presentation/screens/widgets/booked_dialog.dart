import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:device_calendar/device_calendar.dart';

class BookedDialog extends StatefulWidget {
  const BookedDialog({
    super.key,
    required this.title,
    required this.date,
    required this.time,
  });

  final String title;
  final String date;
  final String time;

  @override
  State<BookedDialog> createState() => _BookedDialogState();
}

class _BookedDialogState extends State<BookedDialog> {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  Future<bool> _requestCalendarPermissions() async {
    var permissionStatus = await _deviceCalendarPlugin.hasPermissions();
    if (permissionStatus.isSuccess && permissionStatus.data == false) {
      permissionStatus = await _deviceCalendarPlugin.requestPermissions();
      return permissionStatus.isSuccess && permissionStatus.data!;
    }
    return permissionStatus.isSuccess && permissionStatus.data!;
  }

  Future<void> _addEventToCalendar() async {
    final hasPermission = await _requestCalendarPermissions();
    if (!hasPermission) {
      await Utils.showToast(AppStrings.addCalError.tr())
          .then((value) => Navigator.pop(context));
      return;
    }
    await _deviceCalendarPlugin
        .retrieveCalendars()
        .then((calendarsResult) async {
      if (calendarsResult.isSuccess && calendarsResult.data != null) {
        final calendars = calendarsResult.data!;
        final selectedCalendar = await showDialog<Calendar>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.all(AppPadding.p18.sp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.selectCalendar.tr(),
                      style: getBoldTextStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    SizedBox(height: AppSize.s2.h),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: calendars.length,
                      itemBuilder: (BuildContext context, int index) {
                        final calendar = calendars[index];
                        return InkWell(
                          onTap: () => Navigator.pop(context, calendar),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSize.s2.h,
                            ),
                            child: Text(
                              calendar.name ?? "",
                              style: getRegularTextStyle(
                                fontSize: FontSize.s16,
                                color: ColorManager.textPrimaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
        if (selectedCalendar != null) {
          final event = Event(selectedCalendar.id, title: widget.title);
          final editedDate = widget.date.split("-");
          final editedTime = widget.time.split(":");
          event.start = TZDateTime.from(
              DateTime(
                int.parse(editedDate[0]),
                int.parse(editedDate[1]),
                int.parse(editedDate[2]),
                int.parse(editedTime[0]),
                int.parse(editedTime[1]),
                int.parse(editedTime[2]),
              ),
              Location('UTC', [minTime], [0], [TimeZone.UTC]));
          event.end = event.start?.add(const Duration(hours: 1));
          event.allDay = false;

          // Save the event to the calendar
          final createEventResult =
              await _deviceCalendarPlugin.createOrUpdateEvent(event);
          if (createEventResult?.isSuccess == true) {
            await Utils.showToast(AppStrings.addCalSuccess.tr())
                .then((value) => Navigator.pop(context));
          } else {
            await Utils.showToast(AppStrings.addCalError.tr())
                .then((value) => Navigator.pop(context));
          }
        }
      } else {
        await Utils.showToast(AppStrings.addCalError.tr())
            .then((value) => Navigator.pop(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text(''),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageAssets.appointmentBooked,
                width: 250,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text(
                AppStrings.appointmentBooked.tr(),
                style: getBoldTextStyle(
                  fontSize: FontSize.s24,
                  color: ColorManager.textPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSize.s0_5.h),
              Text(
                AppStrings.appointmentBookedDesc.tr(),
                style: getRegularTextStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSize.s2.h),
              DrPurpleAppButton(
                title: AppStrings.addCalender.tr(),
                onPress: _addEventToCalendar,
              ),
              SizedBox(height: AppSize.s2.h),
              DrPurpleAppButton(
                width: context.width(),
                title: AppStrings.close.tr(),
                switchColors: true,
                color: instance<ThemeCubit>().isThemeDark
                    ? ColorManager.black
                    : ColorManager.greyShade,
                onPress: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        actions: const <Widget>[],
      );
}
