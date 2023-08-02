import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class AppThemeData {
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: ColorManager.white,
      primaryColor: ColorManager.appColorPrimary,
      primaryColorDark: ColorManager.appColorPrimary,
      hoverColor: Colors.white54,
      dividerColor: viewLineColor,
      fontFamily: FontConstants.fontFamily,
      appBarTheme: AppBarTheme(
        color: ColorManager.primary,
        titleTextStyle: getMediumTextStyle(
          color: ColorManager.white,
          fontSize: FontSize.s18,
        ),
        iconTheme: const IconThemeData(color: ColorManager.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: ColorManager.primary,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
      colorScheme: const ColorScheme.light(
        primary: ColorManager.appColorPrimary,
        error: ColorManager.red,
      ),
      cardTheme: const CardTheme(color: Colors.white),
      cardColor: Colors.white,
      iconTheme: const IconThemeData(color: textPrimaryColor),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: whiteColor),
      textTheme: const TextTheme(
        labelLarge: TextStyle(color: ColorManager.appColorPrimary),
        titleLarge: TextStyle(color: textPrimaryColor),
        titleSmall: TextStyle(color: textSecondaryColor),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith(
          (states) => getRegularTextStyle(color: ColorManager.white),
        ),
        backgroundColor: ColorManager.primary,
        shadowColor: ColorManager.primary,
        surfaceTintColor: ColorManager.white,
        indicatorColor: ColorManager.white,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      )).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
  );

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: ColorManager.appBackgroundColorDark,
      highlightColor: ColorManager.appBackgroundColorDark,
      appBarTheme: AppBarTheme(
        color: ColorManager.primary,
        titleTextStyle: getMediumTextStyle(
          color: ColorManager.black,
          fontSize: FontSize.s18,
        ),
        iconTheme: const IconThemeData(color: ColorManager.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: ColorManager.primary,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      primaryColor: ColorManager.colorPrimaryBlack,
      dividerColor: const Color(0xFFDADADA).withOpacity(0.3),
      primaryColorDark: ColorManager.colorPrimaryBlack,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: ColorManager.white),
      hoverColor: Colors.black12,
      fontFamily: FontConstants.fontFamily,
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: ColorManager.appBackgroundColorDark),
      primaryTextTheme: TextTheme(
          titleLarge: primaryTextStyle(color: Colors.white),
          labelSmall: primaryTextStyle(color: Colors.white)),
      cardTheme: const CardTheme(color: ColorManager.cardBackgroundBlackDark),
      cardColor: ColorManager.appSecondaryBackgroundColor,
      iconTheme: const IconThemeData(color: whiteColor),
      textTheme: const TextTheme(
        labelLarge: TextStyle(color: ColorManager.colorPrimaryBlack),
        titleLarge: TextStyle(color: ColorManager.white),
        titleSmall: TextStyle(color: Colors.white54),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.dark(
              primary: ColorManager.appBackgroundColorDark,
              onPrimary: ColorManager.cardBackgroundBlackDark,
              primaryContainer: ColorManager.colorPrimaryBlack,
              error: Color(0xFFCF6676))
          .copyWith(secondary: ColorManager.white),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith(
          (states) => getRegularTextStyle(color: ColorManager.black),
        ),
        backgroundColor: ColorManager.primary,
        shadowColor: ColorManager.primary,
        surfaceTintColor: ColorManager.black,
        indicatorColor: ColorManager.black,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      )).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
  );
}
