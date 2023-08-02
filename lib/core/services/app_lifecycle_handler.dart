import 'package:dr_purple/app/app_management/app_lifecycle_management/app_lifecycle_management.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLifecycleEventHandler extends WidgetsBindingObserver {
  bool _isAppInBackground = false;
  bool _isAppDetached = false;

  bool get isAppInBackground => _isAppInBackground;

  bool get isAppDetached => _isAppDetached;

  static final AppLifecycleEventHandler _instance =
      AppLifecycleEventHandler._();

  AppLifecycleEventHandler._();

  factory AppLifecycleEventHandler() => _instance;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (kDebugMode) {
      print(
          '<<<<<<<<<<<<<<<<<<< app current state >>>>>>>>>>>>>>>>>>>>>>: $state');
    }
    switch (state) {
      case AppLifecycleState.resumed:
        _isAppDetached = false;
        _isAppInBackground = false;
        await whenAppResumed();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        _isAppDetached = false;
        _isAppInBackground = true;
        await whenAppBackgrounded();
        break;
      case AppLifecycleState.detached:
        _isAppDetached = true;
        _isAppInBackground = false;
        await whenAppDetached();
        break;
    }
  }

  Future<void> whenAppDetached() async {}

  Future<void> whenAppBackgrounded() async =>
      await instance<AppLifecycleActions>().appWentToBackground();

  Future<void> whenAppResumed() async =>
      await instance<AppLifecycleActions>().appGotMainContext();
}
