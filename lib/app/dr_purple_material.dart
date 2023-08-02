import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/app/app_configurations/scroll_behavior.dart';
import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/theme/theme_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurpleMaterial extends StatefulWidget {
  /// named constructor
  const DrPurpleMaterial._internal();

  /// singleton or single instance
  static const DrPurpleMaterial _instance = DrPurpleMaterial._internal();

  /// factory
  factory DrPurpleMaterial() => _instance;

  @override
  State<DrPurpleMaterial> createState() => _DrPurpleMaterialState();
}

class _DrPurpleMaterialState extends State<DrPurpleMaterial> {
  @override
  void didChangeDependencies() {
    context.setLocale(instance<LanguageManager>().locale);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
        bloc: instance<ThemeCubit>(),
        builder: (context, state) => ResponsiveSizer(
          builder: (context, orientation, deviceType) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            scrollBehavior: StretchScrollBehavior(),
            title: AppConfigurations.applicationName,
            routerConfig: RouteGenerator.router,
            themeAnimationCurve: Curves.easeInOutCubicEmphasized,
            theme: !instance<ThemeCubit>().isThemeDark
                ? AppThemeData.lightTheme
                : AppThemeData.darkTheme,
          ),
        ),
      );
}
