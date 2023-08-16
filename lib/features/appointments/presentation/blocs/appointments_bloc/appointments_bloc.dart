import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/cancel_appointment/cancel_appointment_params.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_all_appointments/get_all_appointments_params.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/get_all_appointments_api_response/get_all_appointments_api_response.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_all_appointments_entity.dart';
import 'package:dr_purple/features/appointments/domain/use_cases/cancel_appointment_use_case.dart';
import 'package:dr_purple/features/appointments/domain/use_cases/get_all_appointments_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointments_event.dart';

part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final GetAllAppointmentsUseCase _getAllAppointmentsUseCase;
  final CancelAppointmentUseCase _cancelAppointmentUseCase;
  final List<AppointmentModel> _appointments = List.empty(growable: true);

  List<AppointmentModel> get appointments => _appointments;

  AppointmentsBloc(
    this._getAllAppointmentsUseCase,
    this._cancelAppointmentUseCase,
  ) : super(AppointmentsInitial()) {
    on<GetMyAppointments>((event, emit) async {
      emit(AppointmentsLoading(
          loadingType: AppointmentsBlocStateType.getMyAppointments));
      String errorMessage = Constants.empty;
      GetAllAppointmentsEntity? getAllAppointmentsResponse;
      _appointments.clear();
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
          for (var app in getAllAppointmentsResponse!.appointments!) {
            _appointments.add(app);
          }
        }
        emit(AppointmentsLoaded(
            loadedType: AppointmentsBlocStateType.getMyAppointments));
      }
    });

    on<CancelAppointmentEvent>((event, emit) async {
      emit(AppointmentsLoading(
          loadingType: AppointmentsBlocStateType.cancelAppointment));
      String errorMessage = Constants.empty;
      var res = await _cancelAppointmentUseCase.call(CancelAppointmentParams(
          body: CancelAppointmentParamsBody(id: event.id)));
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) => false);
      if (isError) {
        emit(AppointmentsError(
          errorType: AppointmentsBlocStateType.cancelAppointment,
          errorMessage: errorMessage,
        ));
      } else {
        emit(AppointmentsLoaded(
            loadedType: AppointmentsBlocStateType.cancelAppointment));
      }
    });
  }
}
