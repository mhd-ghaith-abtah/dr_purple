import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/features/appointments/presentation/screens/widgets/apppointments_details_list.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_services_api_response/get_all_services_api_response.dart';
import 'package:dr_purple/features/home/presentation/blocs/book_appointment_bloc/book_appointment_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmAppointmentComponent extends StatelessWidget {
  const ConfirmAppointmentComponent({
    super.key,
    required this.bookAppointmentBloc,
    required this.services,
  });

  final BookAppointmentBloc bookAppointmentBloc;
  final List<ServiceModel> services;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSize.s2.h),
              Padding(
                padding: EdgeInsetsDirectional.only(start: AppPadding.p4.w),
                child: Text(
                  AppStrings.confirmAppointment.tr(),
                  style: getBoldTextStyle(
                    fontSize: FontSize.s24,
                    color: ColorManager.textPrimaryColor,
                  ),
                ),
              ),
              SizedBox(height: AppSize.s1.h),
              AppointmentDetailsList(
                bookAppointmentBloc: bookAppointmentBloc,
                services: services,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
