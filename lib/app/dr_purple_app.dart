import 'dart:async';

import 'package:dr_purple/app/dr_purple_material.dart';
import 'package:dr_purple/core/services/app_lifecycle_handler.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:flutter/material.dart';

class DrPurpleApp extends StatefulWidget {
  /// named constructor
  const DrPurpleApp._internal();

  /// singleton or single instance
  static const DrPurpleApp _instance = DrPurpleApp._internal();

  /// factory
  factory DrPurpleApp() => _instance;

  @override
  State<DrPurpleApp> createState() => _DrPurpleAppState();
}

class _DrPurpleAppState extends State<DrPurpleApp> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async => await Utils.precacheAssets(context));
    WidgetsBinding.instance.addObserver(AppLifecycleEventHandler());
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(AppLifecycleEventHandler());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DrPurpleMaterial();
}
