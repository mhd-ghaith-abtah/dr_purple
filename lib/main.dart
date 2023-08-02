import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/app/dr_purple_app.dart';
import 'package:dr_purple/core/services/background_uploader/background_uploader.dart';
import 'package:dr_purple/core/services/firebase_messaeging_service.dart';
import 'package:dr_purple/core/services/log_service.dart';
import 'package:dr_purple/core/services/notification_service/notification_service.dart';
import 'package:dr_purple/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  /// flutter
  WidgetsFlutterBinding.ensureInitialized();

  /// localization
  await EasyLocalization.ensureInitialized();

  /// dependency injection
  await initAppModule();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingService().initFirebaseMessaging();

  /// check theme
  instance<ThemeCubit>().initTheme();

  /// notification channels
  await instance<NotificationService>().initNotifications();
  await instance<NotificationService>().dismissAllNotifications();

  /// background uploader
  await BackgroundUploader.setFlutterUploaderBackgroundHandler();
  BackgroundUploader.initializeListeners();

  /// app language
  instance<LanguageManager>().initiateLocale();

  /// init log errors to file
  await LogService().initializeLoggingService();

  runApp(
    EasyLocalization(
      supportedLocales: SupportedLanguages.all,
      path: translationAssetsPath,
      child: DrPurpleApp(),
    ),
  );
}
