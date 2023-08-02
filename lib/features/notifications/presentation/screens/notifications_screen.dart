import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/app/dummy_test_data/dummy_test_data.dart';
import 'package:dr_purple/core/widgets/design/dr_purple_notification_list_item_design.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationData> data = notificationDataList();
  bool checked = false;
  int? newNotification = 3;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: DrPurpleScaffold(
          body: _screenContent(context),
        ),
      );

  Widget _screenContent(BuildContext context) => Column(
        children: [
          _notificationsAppBar(context),
          SizedBox(width: AppSize.s2.w),
          Container(
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(),
              backgroundColor: instance<ThemeCubit>().isThemeDark
                  ? ColorManager.black
                  : ColorManager.white,
            ),
            child: Column(
              children: [
                _notificationsData(),
                SizedBox(height: AppSize.s1.h),
              ],
            ),
          ).expand(),
        ],
      );

  Widget _notificationsData() => SingleChildScrollView(
        child: Column(
          children: data
              .map((e) =>
                  DrPurpleNotificationListItemDesign(notificationData: e))
              .toList(),
        ).paddingSymmetric(horizontal: AppPadding.p4.w),
      ).expand();

  Widget _notificationsAppBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                AppStrings.notificationsNav.tr(),
                style: getBoldTextStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.white,
                ),
              ),
              SizedBox(width: AppSize.s2.w),
              checked == false
                  ? Container(
                      padding: EdgeInsets.all(AppPadding.p10.sp),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: ColorManager.white,
                        boxShape: BoxShape.circle,
                      ),
                      child: Text(
                        newNotification.toString(),
                        style: getRegularTextStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ).onTap(() {
                      openBottomSheet();
                    })
                  : Container(),
            ],
          ),
          Container(
            padding: EdgeInsets.all(AppPadding.p8.sp),
            decoration: boxDecorationWithRoundedCorners(
              boxShape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              backgroundColor: context.cardColor,
            ),
            child: Icon(
              Icons.settings,
              color:instance<ThemeCubit>().isThemeDark
                  ? ColorManager.black
                  : ColorManager.primary,
              size: AppSize.s20,
            ),
          ),
        ],
      ).paddingAll(AppPadding.p18.sp);

  void openBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(AppPadding.p18.sp),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(
                topRight: AppSize.s12,
                topLeft: AppSize.s12,
              ),
              backgroundColor: instance<ThemeCubit>().isThemeDark
                  ? ColorManager.black
                  : ColorManager.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: AppSize.s7.h,
                  width: context.width() / 2.5,
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p2.h),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: ColorManager.primary,
                    borderRadius: radius(AppSize.s12),
                  ),
                  child: Text(
                    AppStrings.markAllRead.tr(),
                    textAlign: TextAlign.center,
                    style: getBoldTextStyle(
                      color: ColorManager.white,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ).onTap(
                  () {
                    setState(
                      () {
                        checked = true;
                      },
                    );
                    GoRouter.of(context).pop();
                  },
                ),
                Container(
                  height: AppSize.s7.h,
                  width: context.width() / 2.5,
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p2.h),
                  decoration: boxDecorationWithRoundedCorners(
                    border: Border.all(color: ColorManager.primary),
                    borderRadius: radius(AppSize.s12),
                    backgroundColor: instance<ThemeCubit>().isThemeDark
                        ? ColorManager.black
                        : ColorManager.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.deleteAll.tr(),
                        textAlign: TextAlign.center,
                        style: getBoldTextStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      SizedBox(width: AppSize.s1.w),
                      Icon(
                        Icons.delete_outline,
                        color: ColorManager.primary,
                        size: AppSize.s20,
                      ).paddingBottom(AppPadding.p4.h),
                    ],
                  ),
                ).onTap(
                  () {
                    GoRouter.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
