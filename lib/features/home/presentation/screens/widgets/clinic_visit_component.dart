import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_services_api_response/get_all_services_api_response.dart';
import 'package:dr_purple/features/home/presentation/blocs/book_appointment_bloc/book_appointment_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClinicVisitComponent extends StatefulWidget {
  const ClinicVisitComponent({
    super.key,
    required this.services,
    required this.bookAppointmentBloc,
  });

  final List<ServiceModel> services;
  final BookAppointmentBloc bookAppointmentBloc;

  @override
  State<ClinicVisitComponent> createState() => _ClinicVisitComponentState();
}

class _ClinicVisitComponentState extends State<ClinicVisitComponent> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppSize.s1.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.services.tr(),
                      style: getBoldTextStyle(
                        fontSize: FontSize.s24,
                        color: ColorManager.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: AppSize.s1.h),
                    Text(
                      AppStrings.selectServiceDesc.tr(),
                      style: getRegularTextStyle(
                        color: ColorManager.textSecondaryColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                    SizedBox(height: AppSize.s1.h),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: AppPadding.p4.w),
            SizedBox(height: AppSize.s2.h),
            ListView.builder(
              padding: EdgeInsets.only(
                right: AppPadding.p4.w,
                left: AppPadding.p4.w,
                bottom: AppPadding.p9.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.services.length,
              itemBuilder: (context, index) =>
                  BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
                buildWhen: (prev, state) =>
                    state is BookAppointmentLoaded &&
                    state.loadedType ==
                        BookAppointmentBlocStateType.selectService,
                builder: (context, state) => Container(
                  margin: const EdgeInsets.only(bottom: AppPadding.p16),
                  padding: const EdgeInsets.all(AppPadding.p8),
                  decoration: boxDecorationWithRoundedCorners(
                    border: Border.all(
                      color: widget.bookAppointmentBloc.selectedServiceId ==
                              widget.services[index].id
                          ? ColorManager.primary
                          : ColorManager.lightGrey100,
                    ),
                    backgroundColor: context.cardColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Utils.getImageByServiceName(
                                widget.services[index].name!),
                            height: AppSize.s75,
                            width: AppSize.s75,
                            fit: BoxFit.fill,
                          ).paddingAll(AppPadding.p8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.services[index].name!,
                                style: getBoldTextStyle(
                                  fontSize: FontSize.s18,
                                  color: ColorManager.textPrimaryColor,
                                ),
                              ),
                              SizedBox(height: AppSize.s1.h),
                              Text(
                                AppStrings.estimatedDuration.tr(args: [
                                  Utils.getDuration(
                                      widget.services[index].duration!)
                                ]),
                                style: getRegularTextStyle(
                                  color: ColorManager.textSecondaryColor,
                                  fontSize: FontSize.s14,
                                ),
                              ),
                              SizedBox(height: AppSize.s1.h),
                              Text(
                                AppStrings.price.tr(args: [
                                  widget.services[index].price.toString()
                                ]),
                                style: getBoldTextStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s1.h),
                    ],
                  ),
                ),
              ).onTap(
                () => widget.bookAppointmentBloc.add(SelectService(
                  serviceId: widget.services[index].id!,
                )),
              ),
            ),
          ],
        ),
      );
}
