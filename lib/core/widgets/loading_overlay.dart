import 'dart:ui';

import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class LoadingOverlay {
  BuildContext _context;

  void hide() => Navigator.pop(_context);

  void show() => showDialog(
        context: _context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return const _FullScreenLoader();
        },
      );

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) =>
      LoadingOverlay._create(context);
}

class _FullScreenLoader extends StatefulWidget {
  const _FullScreenLoader({Key? key}) : super(key: key);

  @override
  State<_FullScreenLoader> createState() => _FullScreenLoaderState();
}

class _FullScreenLoaderState extends State<_FullScreenLoader> {
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2,
            sigmaY: 2,
          ),
          child: WidgetAnimator(
            atRestEffect:
                WidgetRestingEffects.size(duration: AppDurations.slow),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.white,
                ),
                child: Image.asset(
                  ImageAssets.appLogo,
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          ),
        ),
      );
}
