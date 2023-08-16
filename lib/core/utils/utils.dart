import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/widgets/sheets/valet_media_source_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as intl;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';

class Utils {
  static Future<void> showToast(String message) async =>
      await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: ColorManager.primary,
        textColor: ColorManager.white,
        gravity: ToastGravity.SNACKBAR,
      );

  static void showCustomToast(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
      );

  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  static bool isEmailValid(String email) =>
      Constants.emailRegex.hasMatch(email);

  static bool isPhoneNumberValid(String phoneNumber) =>
      Constants.phoneNumberRegex.hasMatch("+963$phoneNumber");

  static bool isPasswordValid(String password) =>
      Constants.passwordRegex.hasMatch(password);

  static bool isNameValid(String name) => name.length >= 2;

  static Future precacheAssets(BuildContext context) async =>
      await precacheImage(const AssetImage(ImageAssets.appLogo), context)
          .then((value) async => await precacheImage(
              const AssetImage(ImageAssets.firstSlideImage), context))
          .then((value) async => await precacheImage(
              const AssetImage(ImageAssets.secondSlideImage), context))
          .then((value) async => await precacheImage(
              const AssetImage(ImageAssets.thirdSlideImage), context))
          .then((value) async => await precacheImage(
              const AssetImage(ImageAssets.authImage), context))
          .then((value) async => await precacheImage(
              const AssetImage(ImageAssets.verifyAccountImage), context));

  static String parsePhoneNumberForServer(
    String phoneNumber,
    String countryCode,
  ) {
    String newPhoneNumber = "${countryCode.substring(1)}-";
    if (phoneNumber.startsWith("0")) {
      phoneNumber = phoneNumber.substring(0);
    }
    newPhoneNumber += phoneNumber;
    return newPhoneNumber;
  }

  static String parsePhoneNumberForMobile(
    String phoneNumber,
  ) {
    final splat = phoneNumber.split("-");
    return "+${splat.first} ${splat.last}";
  }

  static String getDateFromString(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        intl.DateFormat('yyyy-MM-dd, HH:mm').format(dateTime);
    return formattedDate;
  }

  static String getTimeFromUTCString(String date) {
    final formattedDate = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.parse(date.split(":").first),
      int.parse(date.split(":").last),
    ).toLocal();
    String localTime = Constants.empty;
    if (formattedDate.hour < 10) {
      localTime = "0${formattedDate.hour}:";
    } else {
      localTime = "${formattedDate.hour}:";
    }
    if (formattedDate.minute < 10) {
      localTime = "${localTime}0${formattedDate.minute}";
    } else {
      localTime = "$localTime${formattedDate.minute}";
    }
    return localTime;
  }

  static String getDay(String date) {
    DateTime newDate = DateTime.parse(date);
    return newDate.day.toString();
  }

  static String getMonthName(String date) {
    DateTime newDate = DateTime.parse(date);
    return DateFormat.MMMM(instance<LanguageManager>().locale.toString())
        .format(newDate);
  }

  static String getDuration(String duration) {
    final time = duration.split(":").map((e) => int.parse(e)).toList();
    Duration newDuration =
        Duration(hours: time[0], minutes: time[1], seconds: time[2]);
    final durationSeconds = newDuration.inSeconds;
    double allMinutes = 0.0;
    allMinutes = durationSeconds / 60;
    int minutes = allMinutes.round();
    String formattedDuration = Constants.empty;
    if (minutes > 59) {
      allMinutes = minutes / 60;
      int newMinutes = minutes % 60;
      int hours = allMinutes.toInt();
      if (instance<LanguageManager>().isArabic) {
        if (hours > 2 && hours < 11) {
          formattedDuration += "$hours ${AppStrings.hours.tr()}";
        } else if (hours == 1 || hours > 10) {
          formattedDuration += "$hours ${AppStrings.hour.tr()}";
        }
        if (newMinutes > 2 && newMinutes < 11) {
          formattedDuration += ", $newMinutes ${AppStrings.minutes.tr()}";
        } else if (newMinutes == 1 || newMinutes > 10) {
          formattedDuration += ", $newMinutes ${AppStrings.minute.tr()}";
        }
      } else {
        if (hours > 1) {
          formattedDuration += "$hours ${AppStrings.hours.tr()}";
        } else {
          formattedDuration += "$hours ${AppStrings.hour.tr()}";
        }
        if (newMinutes > 1) {
          formattedDuration += ", $newMinutes ${AppStrings.minutes.tr()}";
        } else if (newMinutes == 1) {
          formattedDuration += ", $newMinutes ${AppStrings.minute.tr()}";
        }
      }
    } else {
      if (instance<LanguageManager>().isArabic) {
        if (minutes > 2 && minutes < 11) {
          formattedDuration += "$minutes ${AppStrings.minutes.tr()}";
        } else if (minutes == 1 || minutes > 10) {
          formattedDuration += "$minutes ${AppStrings.minute.tr()}";
        }
      } else {
        if (minutes > 1) {
          formattedDuration += "$minutes ${AppStrings.minutes.tr()}";
        } else if (minutes == 1) {
          formattedDuration += "$minutes ${AppStrings.minute.tr()}";
        }
      }
    }
    return formattedDuration;
  }

  static String getAppointmentTime(String date, String time) {
    final timeSplit = time.split(":");
    return "$date ${AppStrings.atHour.tr()} ${timeSplit[0]}:${timeSplit[1]}";
  }

  static String getAppointmentBookTime(String date, {bool addTime = true}) {
    DateTime newDate = DateTime.parse(date)
        .add(addTime ? const Duration(hours: 3) : const Duration());
    final formattedHour = DateFormat.Hm().format(newDate);
    final formattedDate =
        DateFormat.MMMM(instance<LanguageManager>().locale.toString())
            .format(newDate);
    final formattedDay = DateFormat.d().format(newDate);
    return "$formattedDay $formattedDate ${AppStrings.atHour.tr()} $formattedHour";
  }

  static String getAppointmentTimeWithoutDate(String time) {
    final timeSplit = time.split(":");
    return "${timeSplit[0]}:${timeSplit[1]}";
  }

  static String getAppointmentState(String state) {
    switch (state) {
      case Constants.bookedServiceTimeState:
        return AppStrings.inProgress.tr();
      case Constants.canceledServiceTimeState:
        return AppStrings.canceled.tr();
      case Constants.doneServiceTimeState:
        return AppStrings.done.tr();
      default:
        return AppStrings.unknown.tr();
    }
  }

  static String getImageByServiceName(String serviceName) {
    switch (serviceName) {
      case "oxyGeneo":
        return ImageAssets.oxyGeneo;
      case "Plasma IQ":
        return ImageAssets.plasmaIq;
      case "Light Therapy":
        return ImageAssets.lightTherapy;
      case "Botox":
        return ImageAssets.botox;
      case "Lifting":
        return ImageAssets.lifting;
      case "Electrolysis":
        return ImageAssets.electrolysis;
      case "Photo Depilation":
        return ImageAssets.photoEpilation;
      default:
        return ImageAssets.lifting;
    }
  }

  static String getImageByMaterialName(String materialName) {
    switch (materialName) {
      case "Vegan BB Cream":
        return ImageAssets.veganBBCream;
      case "Brightening Day Cream":
        return ImageAssets.brighteningDayCream;
      default:
        return ImageAssets.gydratingGlacialMoisturizingCream;
    }
  }

  /// dialogs
  static AwesomeDialog dialog({
    required BuildContext context,
    required DialogType dialogType,
    required String okButtonTitle,
    required String dialogTitle,
    required String dialogDesc,
    required Function()? onPressCancel,
    required Function()? onPressOk,
    bool swapColors = false,
  }) =>
      AwesomeDialog(
        useRootNavigator: false,
        context: context,
        dialogType: dialogType,
        borderSide: BorderSide(
          color: instance<ThemeCubit>().isThemeDark
              ? ColorManager.black
              : ColorManager.primary,
          width: AppSize.s7.sp,
        ),
        width: AppSize.s100.w,
        dialogBorderRadius:
            const BorderRadius.all(Radius.circular(AppSize.s10)),
        buttonsBorderRadius:
            const BorderRadius.all(Radius.circular(AppSize.s10)),
        buttonsTextStyle:
            getRegularTextStyle(color: ColorManager.textPrimaryColor),
        btnCancelText: AppStrings.cancelAction.tr(),
        btnOkText: okButtonTitle,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: dialogTitle,
        titleTextStyle: getBoldTextStyle(
            color: ColorManager.textPrimaryColor, fontSize: FontSize.s20),
        desc: dialogDesc,
        descTextStyle: getRegularTextStyle(
            color: ColorManager.textPrimaryColor, fontSize: FontSize.s16),
        btnOkColor: swapColors ? ColorManager.red : null,
        btnCancelColor: swapColors ? const Color(0xFF00CA71) : null,
        btnCancelOnPress: onPressCancel,
        btnOkOnPress: onPressOk,
      );

  static Future<void> showMediaSourceBottomSheet({
    required BuildContext context,
    required Function() onPressCamera,
    required Function() onPressGallery,
  }) async =>
      Platform.isAndroid
          ? await showModalBottomSheet(
              context: context,
              builder: (context) => ValetMediaSourceBottomSheet(
                onPressCamera: onPressCamera,
                onPressGallery: onPressGallery,
              ),
            )
          : await showCupertinoModalPopup(
              context: context,
              builder: (context) => ValetMediaSourceBottomSheet(
                onPressCamera: onPressCamera,
                onPressGallery: onPressGallery,
              ),
            );
}
