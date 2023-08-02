import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:flutter/material.dart';

class DrPurpleTextButton extends StatelessWidget {
  const DrPurpleTextButton({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final Function() onPress;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPress,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: getBoldTextStyle(
            color: ColorManager.white,
            fontSize: FontSize.s16,
          ),
        ),
      );
}
