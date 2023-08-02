import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:flutter/material.dart';

class DrPurpleScaffold extends StatelessWidget {
  const DrPurpleScaffold({
    Key? key,
    this.backgroundColor,
    this.appBar,
    this.body,
    this.bottomNavBar,
  }) : super(key: key);

  final Color? backgroundColor;
  final AppBar? appBar;
  final Widget? body;
  final Widget? bottomNavBar;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor ?? ColorManager.primary,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavBar,
      );
}
