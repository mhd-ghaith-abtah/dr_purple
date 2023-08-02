import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DrPurpleBackButton extends StatelessWidget {
  const DrPurpleBackButton({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.only(top: 24.0, start: 24.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Icon(Icons.arrow_back_ios, color: color, size: AppSize.s22),
        ).onTap(() => context.pop()),
      );
}
