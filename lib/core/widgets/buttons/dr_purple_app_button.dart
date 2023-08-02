import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DrPurpleAppButton extends StatelessWidget {
  const DrPurpleAppButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.switchColors = false,
    this.width,
    this.color,
  }) : super(key: key);

  final String title;
  final Function()? onPress;
  final bool switchColors;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) => AppButton(
        onTap: onPress,
        width: switchColors ? width : double.infinity,
        color:
            color ?? (switchColors ? ColorManager.white : ColorManager.primary),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: getBoldTextStyle(
            color: switchColors ? ColorManager.primary : ColorManager.white,
            fontSize: FontSize.s16,
          ),
        ),
      );
}
