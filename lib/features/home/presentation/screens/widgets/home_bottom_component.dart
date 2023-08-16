import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dummy_test_data/dummy_test_data.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/home/presentation/blocs/services_bloc/services_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class HomeBottomComponent extends StatelessWidget {
  HomeBottomComponent({super.key, required this.servicesBloc});

  final ServicesBloc servicesBloc;
  final List<DepartmentData> departmentsList = departmentsDataList();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          if (state is ServicesLoading &&
              state.loadingType == ServicesBlocStateType.services) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p4.w),
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => Container(
                margin: const EdgeInsets.only(
                  bottom: AppPadding.p8,
                  left: AppPadding.p8,
                ),
                decoration: boxDecorationRoundedWithShadow(
                  AppSize.s12.toInt(),
                  backgroundColor: context.cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: SizedBox(
                        width: 100.w,
                        height: 240.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: 100.w,
                                height: 180.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: AppSize.s1.h),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: AppPadding.p2.w),
                              child: Container(
                                width: 120.0,
                                height: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: AppSize.s0_5.h),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: AppPadding.p2.w),
                              child: Container(
                                width: 120.0,
                                height: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: AppSize.s1_5.h),
                          ],
                        ),
                      ),
                    ).cornerRadiusWithClipRRectOnly(
                      topLeft: AppSize.s8.toInt(),
                      topRight: AppSize.s8.toInt(),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ServicesError &&
              state.errorType == ServicesBlocStateType.services) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: AppSize.s2.h),
                  Text(
                    AppStrings.unKnown.tr(),
                    style: getBoldTextStyle(
                      color: ColorManager.textPrimaryColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(height: AppSize.s2.h),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.refresh,
                      color: ColorManager.primary,
                      size: AppSize.s40,
                    ),
                    alignment: Alignment.center,
                    onPressed: () => servicesBloc.add(GetAllServices()),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: servicesBloc.services
                .map(
                  (ele) => Container(
                    margin: const EdgeInsets.only(
                      bottom: AppPadding.p8,
                      left: AppPadding.p8,
                    ),
                    decoration: boxDecorationRoundedWithShadow(
                      AppSize.s12.toInt(),
                      backgroundColor: context.cardColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Utils.getImageByServiceName(ele.name!),
                          height: 180,
                          width: 100.w,
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.hue,
                        ).cornerRadiusWithClipRRectOnly(
                          topLeft: AppSize.s8.toInt(),
                          topRight: AppSize.s8.toInt(),
                        ),
                        SizedBox(height: AppSize.s1.h),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: AppPadding.p2.w),
                          child: Text(
                            ele.name!,
                            style: getBoldTextStyle(
                              color: ColorManager.textPrimaryColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSize.s0_5.h),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: AppPadding.p2.w),
                          child: Text(
                            AppStrings.price.tr(args: [ele.price.toString()]),
                            style: getRegularTextStyle(
                              color: ColorManager.textSecondaryColor,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSize.s1_5.h),
                      ],
                    ),
                  ),
                )
                .toList(),
          ).paddingSymmetric(horizontal: AppPadding.p4.w);
        },
      );
}
