import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/features/appointments/presentation/screens/widgets/apppointments_details_list.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DrPurpleScaffold(
        backgroundColor: instance<ThemeCubit>().isThemeDark
            ? ColorManager.black
            : ColorManager.white,
        appBar: AppBar(title: Text("Appointment details")),
        body: Container(
          color: instance<ThemeCubit>().isThemeDark
              ? ColorManager.black
              : ColorManager.white,
          child: const AppointmentDetailsList(),
        ).paddingAll(16.0),
      ),
    );
  }
}
