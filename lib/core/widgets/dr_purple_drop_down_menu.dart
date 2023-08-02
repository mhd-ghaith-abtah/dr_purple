import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrPurpleDropDownMenu<T> extends StatelessWidget {
  const DrPurpleDropDownMenu({
    Key? key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: getRegularTextStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textSecondaryColor,
            ),
          ),
          SizedBox(width: AppSize.s5.w),
          DropdownButton<T>(items: items, value: value, onChanged: onChanged),
        ],
      );
}
