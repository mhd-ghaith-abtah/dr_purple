import 'dart:io';

import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ValetMediaSourceBottomSheet extends StatelessWidget {
  const ValetMediaSourceBottomSheet({
    Key? key,
    required this.onPressCamera,
    required this.onPressGallery,
  }) : super(key: key);

  final Function() onPressCamera;
  final Function() onPressGallery;

  @override
  Widget build(BuildContext context) => Platform.isAndroid
      ? _androidMediaSourceBottomSheet(context)
      : _iOSMediaSourceActionSheet(context);

  Widget _iOSMediaSourceActionSheet(BuildContext context) =>
      CupertinoActionSheet(
        message: Text(AppStrings.chooseImageSourceTitle.tr()),
        actions: [
          CupertinoActionSheetAction(
            onPressed: onPressCamera,
            child: Text(
              AppStrings.camera.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorManager.black,
                    fontSize: FontSize.s20,
                  ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: onPressGallery,
            child: Text(
              AppStrings.gallery.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorManager.black,
                    fontSize: FontSize.s20,
                  ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppStrings.cancelAction.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ColorManager.red,
                  fontSize: FontSize.s20,
                ),
          ),
        ),
      );

  Widget _androidMediaSourceBottomSheet(BuildContext context) => BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (context) => Container(
          height: AppSize.s18.h,
          color: ColorManager.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                AppStrings.chooseImageSourceTitle.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: AppSize.s2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AndroidBottomSheetButton(
                    icon: IconAssets.camera,
                    title: AppStrings.camera.tr(),
                    onPressed: onPressCamera,
                  ),
                  SizedBox(width: AppSize.s20.w),
                  AndroidBottomSheetButton(
                    icon: IconAssets.gallery,
                    title: AppStrings.gallery.tr(),
                    onPressed: onPressGallery,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class AndroidBottomSheetButton extends StatelessWidget {
  const AndroidBottomSheetButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final String icon;
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(icon,
              width: AppSize.s50, color: ColorManager.primary),
          SizedBox(height: AppSize.s1.h),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
