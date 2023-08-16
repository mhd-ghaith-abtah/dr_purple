import 'package:device_calendar/device_calendar.dart' as tz;
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/core/services/background_uploader/background_uploader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _notify =
      FlutterLocalNotificationsPlugin();

  /// Channels IDs
  static const uploadingImageChannelID = "uploading_image";
  static const uploadedImageChannelID = "uploaded_image";
  static const firebaseChannelID = "firebase";
  static const reminderChannelID = "reminder";

  /// Channels Group IDs
  static const uploadingImageChannelGroupID = "uploading_images_group";
  static const uploadedImageChannelGroupID = "uploaded_images_group";
  static const firebaseChannelGroupID = "firebase_group";
  static const reminderChannelGroupID = "reminder_group";

  /// Channels Names
  static const uploadingImageChannelName = "Uploading Image";
  static const uploadedImageChannelName = "Uploaded Image";
  static const firebaseChannelName = "Firebase";
  static const reminderChannelName = "Reminder";

  /// Channels Descriptions
  static const uploadingImageChannelDescription =
      "this channel is for uploading images";
  static const uploadedImageChannelDescription =
      "this channel is for uploaded images";
  static const firebaseChannelDescription = "this channel is for firebase";
  static const reminderChannelDescription =
      "this channel is for appointment reminder";

  Future<void> initNotifications() async {
    AndroidInitializationSettings androidInitialize =
        const AndroidInitializationSettings('@drawable/ic_stat_dr_purple');
    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings =
        InitializationSettings(iOS: iosSettings, android: androidInitialize);
    await _notify.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          NotificationController.notificationBackgroundTapHandled,
      onDidReceiveBackgroundNotificationResponse:
          NotificationController.notificationBackgroundTapNotHandled,
    );
    final notificationAppLaunchDetails =
        await _notify.getNotificationAppLaunchDetails();
    await NotificationController.notificationOpenedAppFromTerminatedState(
        notificationAppLaunchDetails);
    initializeTimeZones();
  }

  int createUniqueId() =>
      DateTime.now().millisecondsSinceEpoch.remainder(100000);

  Future scheduleNotification({
    int id = 0,
    required String title,
    required String body,
    required DateTime scheduledNotificationDateTime,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      reminderChannelID,
      reminderChannelName,
      colorized: true,
      color: ColorManager.primary,
      channelDescription: reminderChannelDescription,
      groupKey: reminderChannelGroupID,
      category: AndroidNotificationCategory.reminder,
    );
    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: false,
      presentBadge: false,
      presentSound: false,
      threadIdentifier: reminderChannelID,
      categoryIdentifier: reminderChannelGroupID,
      interruptionLevel: InterruptionLevel.active,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);
    return _notify.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> createAttachmentProgressNotification({
    required int taskId,
    required int progress,
    required List<AndroidNotificationAction> buttons,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      uploadingImageChannelID,
      uploadingImageChannelName,
      colorized: true,
      color: ColorManager.primary,
      channelDescription: uploadingImageChannelDescription,
      groupKey: uploadingImageChannelGroupID,
      showProgress: true,
      maxProgress: 100,
      progress: progress,
      actions: buttons,
      category: AndroidNotificationCategory.progress,
    );
    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: false,
      presentBadge: false,
      presentSound: false,
      threadIdentifier: uploadingImageChannelID,
      categoryIdentifier: uploadingImageChannelGroupID,
      interruptionLevel: InterruptionLevel.active,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);
    await _notify.show(
      taskId,
      "Dr. purple",
      AppStrings.mediaUploadingInProgressNotification.tr(),
      notificationDetails,
    );
  }

  Future<void> createFirebaseNotification({
    required int id,
    required String? title,
    required String? body,
    Map<String, String?>? payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      firebaseChannelID,
      firebaseChannelName,
      colorized: true,
      color: ColorManager.primary,
      channelDescription: firebaseChannelDescription,
      groupKey: firebaseChannelGroupID,
      category: AndroidNotificationCategory.status,
    );
    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      threadIdentifier: firebaseChannelID,
      categoryIdentifier: firebaseChannelGroupID,
      interruptionLevel: InterruptionLevel.active,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);
    await _notify.show(
      id,
      title,
      body,
      notificationDetails,
      // payload: jsonEncode(payload),
    );
  }

  Future<void> createAttachmentCompleteOrFailedNotification({
    required int taskId,
    required String body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      uploadedImageChannelID,
      uploadedImageChannelName,
      colorized: true,
      color: ColorManager.primary,
      channelDescription: uploadedImageChannelDescription,
      groupKey: uploadedImageChannelGroupID,
      category: AndroidNotificationCategory.status,
    );
    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: false,
      presentBadge: false,
      presentSound: false,
      threadIdentifier: uploadedImageChannelID,
      categoryIdentifier: uploadedImageChannelGroupID,
      interruptionLevel: InterruptionLevel.active,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);
    await _notify.show(taskId, "Dr. purple", body, notificationDetails);
  }

  Future<void> dismissNotification(int id, {bool firebase = false}) async =>
      await _notify.cancel(id);

  Future<void> dismissAllNotifications() async => await _notify.cancelAll();
}

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> notificationBackgroundTapNotHandled(
      NotificationResponse details) async {
    if (kDebugMode) {
      print("notificationBackgroundTapNotHandled HANDLER");
    }
    if (details.notificationResponseType ==
        NotificationResponseType.selectedNotificationAction) {
      if (kDebugMode) {
        print('Notification key pressed: ${details.actionId}');
      }
      BackgroundUploader.cancelFileUploading(taskId: details.actionId ?? "");
    }
  }

  static Future<void> notificationBackgroundTapHandled(
      NotificationResponse details) async {
    if (kDebugMode) {
      print("notificationBackgroundTapHandled HANDLER");
    }
    if (details.notificationResponseType ==
        NotificationResponseType.selectedNotificationAction) {
      if (kDebugMode) {
        print('Notification key pressed: ${details.actionId}');
      }
      BackgroundUploader.cancelFileUploading(taskId: details.actionId ?? "");
    }
  }

  static Future<void> notificationOpenedAppFromTerminatedState(
      NotificationAppLaunchDetails? notificationAppLaunchDetails) async {
    if (kDebugMode) {
      print("notificationOpenedAppFromTerminated HANDLER");
    }
    if (notificationAppLaunchDetails
            ?.notificationResponse?.notificationResponseType ==
        NotificationResponseType.selectedNotificationAction) {
      if (kDebugMode) {
        print(
            'Notification key pressed: ${notificationAppLaunchDetails?.notificationResponse?.actionId}');
      }
      BackgroundUploader.cancelFileUploading(
          taskId:
              notificationAppLaunchDetails?.notificationResponse?.actionId ??
                  "");
    }
  }
}
