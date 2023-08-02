import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
  TextDecoration? textDecoration,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    fontWeight: fontWeight,
    decoration: textDecoration,
    color: color,
  );
}

/// thin Century-Gothic font style
TextStyle getThinTextStyle({
  double fontSize = 12.0,
  TextDecoration? textDecoration,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.thin, color, textDecoration);
}

/// light Century-Gothic font style
TextStyle getLightTextStyle({
  double fontSize = 12.0,
  TextDecoration? textDecoration,
  required Color color,
}) {
  return _getTextStyle(
      fontSize, FontWeightManager.light, color, textDecoration);
}

/// regular Century-Gothic font style
TextStyle getRegularTextStyle({
  double fontSize = 12.0,
  TextDecoration? textDecoration,
  required Color color,
}) {
  return _getTextStyle(
      fontSize, FontWeightManager.regular, color, textDecoration);
}

/// medium Century-Gothic font style
TextStyle getMediumTextStyle({
  double fontSize = 12.0,
  TextDecoration? textDecoration,
  required Color color,
}) {
  return _getTextStyle(
      fontSize, FontWeightManager.medium, color, textDecoration);
}

/// bold Century-Gothic font style
TextStyle getBoldTextStyle({
  double fontSize = 12.0,
  TextDecoration? textDecoration,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color, textDecoration);
}
