import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/features/pharmacy/presentation/bloc/pharmacy_bloc/pharmacy_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({super.key});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  late final PharmacyBloc _pharmacyBloc;

  _bind() => _pharmacyBloc = instance<PharmacyBloc>()..add(GetPharmacyEvent());

  @override
  initState() {
    super.initState();
    _bind();
  }

  _disposeBloc() async => await _pharmacyBloc.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _screenContent();

  Widget _screenContent() => BlocProvider(
        create: (context) => _pharmacyBloc,
        child: _languageScreenContent(),
      );

  Widget _languageScreenContent() => DrPurpleScaffold(
        backgroundColor: instance<ThemeCubit>().isThemeDark
            ? ColorManager.black
            : ColorManager.white,
        appBar: AppBar(
          title: Text(AppStrings.pharmacy.tr()),
        ),
        body: BlocBuilder<PharmacyBloc, PharmacyState>(
          builder: (context, state) {
            if (state is PharmacyLoading) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p4.w, vertical: AppPadding.p2.h),
                itemCount: 8,
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
            } else if (state is PharmacyError) {
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
                      onPressed: () => _pharmacyBloc.add(GetPharmacyEvent()),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p4.w, vertical: AppPadding.p2.h),
              itemCount: _pharmacyBloc.materials.length,
              itemBuilder: (BuildContext context, int index) {
                final ele = _pharmacyBloc.materials[index];
                return Container(
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
                        Utils.getImageByMaterialName(ele.material.name),
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
                        padding:
                            EdgeInsetsDirectional.only(start: AppPadding.p2.w),
                        child: Text(
                          ele.material.name,
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
                          AppStrings.price.tr(args: [ele.material.salePrice.toString()]),
                          style: getRegularTextStyle(
                            color: ColorManager.textSecondaryColor,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s1_5.h),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
}
