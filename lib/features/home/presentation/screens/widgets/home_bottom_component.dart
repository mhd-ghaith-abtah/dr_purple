import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
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
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(height: AppSize.s1.h),
          Row(
            children: [
              Text(
                AppStrings.departments.tr(),
                style: getBoldTextStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.textPrimaryColor,
                ),
              ).expand(),
              // Text(
              //   AppStrings.viewAll.tr(),
              //   style: getRegularTextStyle(
              //     color: ColorManager.primary,
              //     fontSize: FontSize.s14,
              //   ),
              // ),
              // SizedBox(width: AppSize.s1.w),
              // RotatedBox(
              //   quarterTurns: instance<LanguageManager>().isArabic ? 2 : 0,
              //   child: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: ColorManager.primary,
              //     size: AppSize.s16,
              //   ),
              // ),
            ],
          ).paddingSymmetric(horizontal: AppPadding.p4.w),
          SizedBox(height: AppSize.s1_5.h),
          HorizontalList(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p4.w),
            wrapAlignment: WrapAlignment.spaceEvenly,
            itemCount: departmentsList.length,
            itemBuilder: (BuildContext context, int index) => Container(
              margin: const EdgeInsets.only(
                top: AppPadding.p8,
                bottom: AppPadding.p8,
                left: AppPadding.p8,
              ),
              padding: EdgeInsets.all(AppPadding.p12.sp),
              decoration: boxDecorationRoundedWithShadow(
                AppSize.s12.toInt(),
                backgroundColor: context.cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    (departmentsList[index].image).validate(),
                    height: AppSize.s80,
                    width: AppSize.s80,
                    fit: BoxFit.fill,
                  ).paddingAll(AppPadding.p10.sp),
                  Text(
                    (departmentsList[index].title).validate(),
                    style: getBoldTextStyle(
                      color: ColorManager.textPrimaryColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(height: AppSize.s0_5.h),
                  Text(
                    (departmentsList[index].subtitle).validate(),
                    style: getRegularTextStyle(
                      color: ColorManager.textSecondaryColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  SizedBox(height: AppSize.s1.h),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Text(
                AppStrings.topOffers.tr(),
                style: getBoldTextStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.textPrimaryColor,
                ),
              ).expand(),
              // Text(
              //   AppStrings.viewAll.tr(),
              //   style: getRegularTextStyle(
              //     color: ColorManager.primary,
              //     fontSize: FontSize.s14,
              //   ),
              // ),
              // SizedBox(width: AppSize.s1.w),
              // RotatedBox(
              //   quarterTurns: instance<LanguageManager>().isArabic ? 2 : 0,
              //   child: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: ColorManager.primary,
              //     size: AppSize.s16,
              //   ),
              // ),
            ],
          ).paddingAll(AppPadding.p18.sp),
          BlocBuilder<ServicesBloc, ServicesState>(
            builder: (context, state) {
              if (state is ServicesLoading &&
                  state.loadingType == ServicesBlocStateType.services) {
                return HorizontalList(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p4.w),
                  wrapAlignment: WrapAlignment.spaceBetween,
                  itemCount: 4,
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
                            width: 250.0,
                            height: 200.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 250.0,
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
              return HorizontalList(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p4.w),
                wrapAlignment: WrapAlignment.spaceBetween,
                itemCount: servicesBloc.services.length,
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
                      Image.asset(
                        Utils.getImageByServiceName(
                            servicesBloc.services[index].name!),
                        height: 140,
                        width: 250,
                        fit: BoxFit.fill,
                        colorBlendMode: BlendMode.hue,
                      ).cornerRadiusWithClipRRectOnly(
                        topLeft: AppSize.s8.toInt(),
                        topRight: AppSize.s8.toInt(),
                      ),
                      SizedBox(height: AppSize.s1.h),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: AppPadding.p2.w),
                        child: Text(
                          servicesBloc.services[index].name!,
                          style: getBoldTextStyle(
                            color: ColorManager.textPrimaryColor,
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s0_5.h),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: AppPadding.p2.w),
                        child: Text(
                          AppStrings.price.tr(args: [
                            servicesBloc.services[index].price.toString()
                          ]),
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
              );
            },
          ),
        ],
      );
}
