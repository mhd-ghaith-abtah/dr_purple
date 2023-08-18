import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/widgets/design/dr_purple_notification_list_item_design.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/features/notifications/presentation/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationsBloc _notificationsBloc;

  _bind() {
    _notificationsBloc = instance<NotificationsBloc>()
      ..add(GetAllNotifications());
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeBloc() async => await _notificationsBloc.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _notificationsBloc,
        child: SafeArea(
          child: DrPurpleScaffold(
            body: _screenContent(context),
          ),
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

  Widget _notificationsData() =>
      BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoaded) {
            if (_notificationsBloc.notifications.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: _notificationsBloc.notifications
                      .map((e) => DrPurpleNotificationListItemDesign(
                          notificationData: e))
                      .toList(),
                ).paddingSymmetric(horizontal: AppPadding.p4.w),
              );
            } else {
              return _emptyNotifications(context);
            }
          } else if (state is NotificationsLoading) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: SizedBox(
                    width: AppSize.s90.w,
                    height: 125.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: AppSize.s90.w,
                            height: 125.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: AppPadding.p8),
                            padding: const EdgeInsets.all(AppPadding.p5),
                            decoration: boxDecorationWithRoundedCorners(
                              borderRadius: radius(AppSize.s12),
                              border: Border.all(
                                color: ColorManager.primary,
                              ),
                              backgroundColor: ColorManager.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).cornerRadiusWithClipRRectOnly(
                  topLeft: AppSize.s8.toInt(),
                  topRight: AppSize.s8.toInt(),
                );
              },
            ).paddingAll(AppPadding.p18.sp);
          } else {
            return _emptyNotifications(context);
          }
        },
      ).expand();

  Widget _emptyNotifications(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 100.w,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                    vertical: AppPadding.p16, horizontal: AppPadding.p16),
                padding: const EdgeInsets.all(AppPadding.p12),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(AppSize.s12),
                  border: Border.all(color: ColorManager.primary),
                  backgroundColor: context.cardColor,
                ),
                child: Text(
                  AppStrings.emptyNotifications.tr(),
                  style: getBoldTextStyle(
                    color: ColorManager.textPrimaryColor,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _notificationsAppBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.notificationsNav.tr(),
            style: getBoldTextStyle(
              fontSize: FontSize.s20,
              color: ColorManager.white,
            ),
          ),
        ],
      ).paddingAll(AppPadding.p18.sp);
}
