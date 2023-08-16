import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/features/home/presentation/blocs/services_bloc/services_bloc.dart';
import 'package:dr_purple/features/settings/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeTopComponent extends StatelessWidget {
  const HomeTopComponent({super.key, required this.servicesBloc});

  final ServicesBloc servicesBloc;

  @override
  Widget build(BuildContext context) => Container(
        height: AppSize.s25.h,
        width: context.width(),
        margin: EdgeInsets.only(bottom: AppPadding.p1.h),
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: ColorManager.primary,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(
              MediaQuery.of(context).size.width,
              AppSize.s80,
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: AppSize.s2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppSize.s22,
                      backgroundColor: ColorManager.cyan,
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        bloc: instance<ProfileBloc>(),
                        builder: (context, state) {
                          if (instance<ProfileBloc>()
                                  .getProfileEntity
                                  ?.gender ==
                              1) {
                            return Image.asset(ImageAssets.maleProfileImage);
                          } else if (instance<ProfileBloc>()
                                  .getProfileEntity
                                  ?.gender ==
                              2) {
                            return Image.asset(ImageAssets.femaleProfileImage);
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: AppSize.s2.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<ProfileBloc, ProfileState>(
                          bloc: instance<ProfileBloc>(),
                          builder: (context, state) {
                            return Text(
                              AppStrings.hiName.tr(args: [
                                instance<ProfileBloc>()
                                        .getProfileEntity
                                        ?.firstName ??
                                    ""
                              ]),
                              style: getBoldTextStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s16,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: AppSize.s0_5.h),
                        Text(
                          AppStrings.welcome.tr(),
                          style: getRegularTextStyle(
                            color: ColorManager.white.withOpacity(0.7),
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     const Icon(Icons.search, color: white, size: AppSize.s24),
                //     SizedBox(width: AppSize.s3.w),
                //   ],
                // )
              ],
            ).paddingSymmetric(horizontal: AppPadding.p4.w),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppPadding.p4.w),
              transform: Matrix4.translationValues(
                  AppSize.s0, AppSize.s16, AppSize.s0),
              alignment: Alignment.center,
              decoration: boxDecorationRoundedWithShadow(12,
                  backgroundColor: context.cardColor),
              child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                spacing: AppSize.s1.h,
                children: [
                  _homeTopItem(
                    context,
                    ImageAssets.bookAppointmentImage,
                    AppStrings.appointment.tr(),
                    () => context.push(
                      "${Routes.homeRoute}/${Routes.bookAppointmentRoute}",
                      extra: servicesBloc,
                    ),
                  ),
                  _homeTopItem(
                    context,
                    ImageAssets.pharmacyImage,
                    AppStrings.pharmacy.tr(),
                    () => context.push(
                      "${Routes.homeRoute}/${Routes.pharmacyRoute}",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _homeTopItem(
    BuildContext context,
    String image,
    String title,
    Function() onPress,
  ) =>
      Container(
        constraints: BoxConstraints(minWidth: context.width() * 0.25),
        padding: EdgeInsets.symmetric(vertical: AppPadding.p2.h),
        child: Column(
          children: [
            Image.asset(
              image,
              width: AppSize.s40,
              height: AppSize.s40,
              fit: BoxFit.fill,
            ),
            SizedBox(height: AppSize.s1.h),
            Text(
              title,
              style: getBoldTextStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ).onTap(onPress);
}
