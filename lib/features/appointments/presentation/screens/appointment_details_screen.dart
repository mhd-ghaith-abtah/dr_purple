import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/get_all_appointments_api_response/get_all_appointments_api_response.dart';
import 'package:dr_purple/features/appointments/presentation/blocs/appointments_bloc/appointments_bloc.dart';
import 'package:dr_purple/features/appointments/presentation/screens/widgets/apppointments_details_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({Key? key, required this.appointmentData})
      : super(key: key);

  final AppointmentModel appointmentData;

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  late final AppointmentsBloc _appointmentsBloc;

  @override
  void initState() {
    super.initState();
    _appointmentsBloc = BlocProvider.of<AppointmentsBloc>(context);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: DrPurpleScaffold(
          backgroundColor: instance<ThemeCubit>().isThemeDark
              ? ColorManager.black
              : ColorManager.white,
          appBar: AppBar(title: Text(AppStrings.appointmentDetails.tr())),
          body: Container(
            color: instance<ThemeCubit>().isThemeDark
                ? ColorManager.black
                : ColorManager.white,
            child: AppointmentDetailsList(
              appointmentData: widget.appointmentData,
              appointmentsBloc: _appointmentsBloc,
            ),
          ).paddingAll(16.0),
        ),
      );
}
