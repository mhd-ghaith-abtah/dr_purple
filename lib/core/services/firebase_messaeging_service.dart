import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/services/notification_service/notification_service.dart';
import 'package:dr_purple/features/notifications/data/local/models/notification_database_model/notification_database_model.dart';
import 'package:dr_purple/features/notifications/data/repositories/notifications_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._();

  FirebaseMessagingService._();

  factory FirebaseMessagingService() => _instance;

  /// get firebase messaging instance
  final _messaging = FirebaseMessaging.instance;

  Future<void> initFirebaseMessaging() async {
    /// request for notification permission
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    /// set background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseBackground);

    /// fcm token changed
    _listenToFCMTokenChanges();

    /// when new notification arrive and app on foreground
    _listenToFirebaseMessages();

    /// if the app has been opened from a notification from the background
    _listenToAppOpenedUsingFirebaseNotificationFromBackground();

    /// if the app has been opened from a notification from terminated state
    _listenToAppOpenedUsingFirebaseNotificationFromTerminatedState();
  }

  void _listenToFirebaseMessages() =>
      FirebaseMessaging.onMessage.listen((message) async {
        // try {
        //   await firebaseMessagingModule();
        // } catch (e) {
        //   if (kDebugMode) {
        //     print(e.toString());
        //   }
        // }
        if (kDebugMode) {
          print("title: ${message.notification?.title}");
          print("body: ${message.notification?.body}");
          print("data: ${message.data}");
        }
        instance<NotificationsRepository>()
            .addNotification(NotificationDatabaseModel(
          title: message.notification?.title,
          body: message.notification?.body,
          date: message.sentTime.toString(),
        ));

        /// show notification on foreground
        // Map<String, String> messageData =
        //     message.data.map((key, value) => MapEntry(key, value.toString()));
        instance<NotificationService>().createFirebaseNotification(
          id: message.messageId.hashCode,
          title: message.notification?.title,
          body: message.notification?.body,
          //payload: messageData,
        );
      });

  void _listenToAppOpenedUsingFirebaseNotificationFromBackground() =>
      FirebaseMessaging.onMessageOpenedApp.listen((message) async {
        if (kDebugMode) {
          print("app has been opened from notification while in background");
          print("title: ${message.notification?.title}");
          print("body: ${message.notification?.body}");
          print("data: ${message.data}");
        }

        // Map<String, String> messageData =
        //     message.data.map((key, value) => MapEntry(key, value.toString()));
        // await instance<AppNotificationDeepLinkNavigationManager>()
        //     .navigateFromNotification(messageData, true);
      });

  Future<void>
      _listenToAppOpenedUsingFirebaseNotificationFromTerminatedState() async =>
          await _messaging.getInitialMessage().then((message) async {
            if (message != null) {
              if (kDebugMode) {
                print(
                    "app has been opened from notification while app terminated");
                print("title: ${message.notification?.title}");
                print("body: ${message.notification?.body}");
                print("data: ${message.data}");
              }
              // Map<String, String?>? messageData = message.data
              //     .map((key, value) => MapEntry(key, value.toString()));
              // await instance<AppNotificationDeepLinkNavigationManager>()
              //     .navigateFromNotification(messageData, false);
            }
          });

  Future<String?> getFCMToken() async => await _messaging.getToken();

  void _listenToFCMTokenChanges() =>
      _messaging.onTokenRefresh.listen((newToken) async {
        // try {
        //   await initRefreshFCMTokenModule();
        //   await instance<UpdateFCMToken>()
        //       .updateFCMToken(newFCMToken: newToken);
        // } catch (e) {
        //   if (kDebugMode) {
        //     print(e.toString());
        //   }
        // }
      });
}

@pragma("vm:entry-point")
Future<void> _firebaseBackground(RemoteMessage message) async {
  // try {
  //   await firebaseMessagingModule();
  //   //await instance<NotificationService>().dismissAllNotifications();
  // } catch (e) {
  //   if (kDebugMode) {
  //     print(e.toString());
  //   }
  // }
  if (kDebugMode) {
    print("title: ${message.notification?.title}");
    print("body: ${message.notification?.body}");
    print("data: ${message.data}");
  }

  neededInBackgroundNotificationsModule();
  instance<NotificationsRepository>().addNotification(NotificationDatabaseModel(
    title: message.notification?.title,
    body: message.notification?.body,
    date: message.sentTime.toString(),
  ));

  /// worker messages
  // if (message.data["type"] == Constants.parkRequestClaimFBMessageType) {
  //   await initWorkerCurrentRequestForBackground();
  //   instance<CurrentRequestBloc>().add(ParkRequestHasBeenClaimed());
  // } else if (message.data["type"] ==
  //     Constants.carReturnRequestFinishFBMessageType) {
  //   await initWorkerCurrentRequestForBackground();
  //   instance<CurrentRequestBloc>().add(FinishReturnRequest());
  // }
  /// pending return requests count
}
