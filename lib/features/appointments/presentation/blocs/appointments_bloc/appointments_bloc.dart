import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_all_appointments/get_all_appointments_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_all_appointments_entity.dart';
import 'package:dr_purple/features/appointments/domain/use_cases/get_all_appointments_use_case.dart';
import 'package:dr_purple/features/appointments/domain/use_cases/get_appointment_use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_service_time/get_all_service_time_params.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time/get_service_time_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_service_time_entity.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_services_entity.dart';
import 'package:dr_purple/features/home/domain/use_cases/get_all_service_time_use_case.dart';
import 'package:dr_purple/features/home/domain/use_cases/get_service_time_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointments_event.dart';

part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final GetAllAppointmentsUseCase _getAllAppointmentsUseCase;
  final GetAppointmentUseCase _getAppointmentUseCase;
  final GetServiceTimeUseCase _getServiceTimeUseCase;
  final GetAllServiceTimeUseCase _getAllServiceTimeUseCase;

  AppointmentsBloc(this._getAllAppointmentsUseCase, this._getAppointmentUseCase,
      this._getServiceTimeUseCase, this._getAllServiceTimeUseCase)
      : super(AppointmentsInitial()) {
    on<GetMyAppointments>((event, emit) async {
      emit(AppointmentsLoading(
          loadingType: AppointmentsBlocStateType.getMyAppointments));
      String errorMessage = Constants.empty;
      GetAllAppointmentsEntity? getAllAppointmentsResponse;
      var res = await _getAllAppointmentsUseCase.call(GetAllAppointmentsParams(
          body: GetAllAppointmentsParamsBody(
        pageSize: 10,
        pageNo: 1,
        skip: 1,
        orderBy: null,
        searchBy: null,
        isAscending: false,
      )));
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        getAllAppointmentsResponse = r;
        return false;
      });
      if (isError) {
        emit(AppointmentsError(
          errorType: AppointmentsBlocStateType.getMyAppointments,
          errorMessage: errorMessage,
        ));
      } else {
        if (getAllAppointmentsResponse?.appointments != null &&
            getAllAppointmentsResponse?.appointments?.isNotEmpty == true) {
          GetAllServiceTimeEntity? getAllServiceTimeEntity;
          var res =
              await _getAllServiceTimeUseCase.call(GetAllServiceTimeParams(
                  body: GetAllServiceTimeParamsBody(
            pageSize: 100,
            pageNo: 1,
            skip: 1,
            orderBy: null,
            searchBy: null,
            isAscending: false,
          )));
          isError = res.fold((l) {
            errorMessage = l.message;
            return true;
          }, (r) {
            getAllServiceTimeEntity = r;
            return false;
          });
          if (isError) {
            emit(AppointmentsError(
              errorType: AppointmentsBlocStateType.getMyAppointments,
              errorMessage: errorMessage,
            ));
          } else {
            // for (var app in getAllAppointmentsResponse!.appointments!) {
            //   var res = await _getServiceTimeUseCase.call(GetServiceTimeParams(
            //       body:
            //           GetServiceTimeParamsBody(serviceId: app.serviceTimeId)));
            // }
          }
        }
        emit(AppointmentsLoaded(
            loadedType: AppointmentsBlocStateType.getMyAppointments));
      }
    });
  }
}
