import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/services/notification_service/notification_service.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/book_appointment/book_appointment_params.dart';
import 'package:dr_purple/features/appointments/domain/use_cases/book_appointment_use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_doctor/get_doctor_params.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time/get_service_time_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_service_time_api_response/get_service_time_api_response.dart';
import 'package:dr_purple/features/home/domain/entities/get_doctor_entity.dart';
import 'package:dr_purple/features/home/domain/use_cases/get_doctor_use_case.dart';

import 'package:dr_purple/features/home/domain/use_cases/get_service_time_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_appointment_event.dart';

part 'book_appointment_state.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  final GetServiceTimeUseCase _getServiceTimeUseCase;
  final GetDoctorUseCase _getDoctorUseCase;
  final BookAppointmentUseCase _bookAppointmentUseCase;

  final List<GetServiceTimeAPIResult> _getServiceTimeResponse =
      List.empty(growable: true);
  final List<GetServiceTimeAPIResult> _serviceTimeResponseFiltered =
      List.empty(growable: true);
  final List<GetDoctorEntity> _doctors = List.empty(growable: true);
  final List<GetDoctorEntity> _filteredDoctors = List.empty(growable: true);

  int _selectedServiceId = -1;
  int _selectedServiceTimeId = -1;

  int get selectedServiceId => _selectedServiceId;

  int get selectedServiceTimeId => _selectedServiceTimeId;

  List<GetServiceTimeAPIResult> get serviceTimeResponseFiltered =>
      _serviceTimeResponseFiltered;

  List<GetDoctorEntity> get filteredDoctors => _filteredDoctors;

  BookAppointmentBloc(this._getServiceTimeUseCase, this._getDoctorUseCase,
      this._bookAppointmentUseCase)
      : super(BookAppointmentInitial()) {
    on<SelectService>((event, emit) {
      _selectedServiceId = event.serviceId;
      emit(BookAppointmentLoaded(
        loadedType: BookAppointmentBlocStateType.selectService,
      ));
    });

    on<SelectServiceTime>((event, emit) {
      _selectedServiceTimeId = event.serviceTimeId;
      emit(BookAppointmentLoaded(
        loadedType: BookAppointmentBlocStateType.selectServiceTime,
      ));
    });

    on<BookAppointment>((event, emit) async {
      emit(BookAppointmentLoading(
        loadingType: BookAppointmentBlocStateType.book,
      ));
      String errorMessage = Constants.empty;
      var res = await _bookAppointmentUseCase.call(BookAppointmentParams(
          body: BookAppointmentParamsBody(id: _selectedServiceTimeId)));

      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        return false;
      });
      if (isError) {
        emit(BookAppointmentError(
          errorType: BookAppointmentBlocStateType.book,
          errorMessage: errorMessage,
        ));
      } else {
        final serviceTime = _serviceTimeResponseFiltered
            .firstWhere((element) => element.id == _selectedServiceTimeId);
        final dateTime =
            DateTime.parse("${serviceTime.date} ${serviceTime.startTime}")
                .subtract(const Duration(hours: 2));
        instance<NotificationService>().scheduleNotification(
          title: AppStrings.appointmentDay.tr(),
          body: AppStrings.appointmentDayRemind.tr(args: [serviceTime.startTime!]),
          scheduledNotificationDateTime: dateTime,
        );
        emit(BookAppointmentLoaded(
          loadedType: BookAppointmentBlocStateType.book,
        ));
      }
    });

    on<GetServiceTimes>((event, emit) async {
      emit(BookAppointmentLoading(
        loadingType: BookAppointmentBlocStateType.getServiceTimes,
      ));
      _getServiceTimeResponse.clear();
      _doctors.clear();
      _selectedServiceTimeId = -1;
      String errorMessage = Constants.empty;
      var res = await _getServiceTimeUseCase.call(GetServiceTimeParams(
          body: GetServiceTimeParamsBody(
        serviceId: _selectedServiceId,
      )));

      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        for (var time in r.serviceTimes!) {
          _getServiceTimeResponse.add(time);
        }
        return false;
      });
      if (isError) {
        emit(BookAppointmentError(
          errorType: BookAppointmentBlocStateType.getServiceTimes,
          errorMessage: errorMessage,
        ));
      } else {
        GetDoctorEntity? getDoctorResponse;
        for (int i = 0; i < _getServiceTimeResponse.length; i++) {
          if (i == 0 ||
              _getServiceTimeResponse[i].contractServiceId !=
                  _getServiceTimeResponse[i - 1].contractServiceId) {
            var res = await _getDoctorUseCase.call(GetDoctorParams(
                body: GetDoctorParamsBody(
              contractServiceId: _getServiceTimeResponse[i].contractServiceId,
            )));
            res.fold((l) => errorMessage = l.message, (r) {
              getDoctorResponse = r;
              _doctors.add(getDoctorResponse!);
            });
          } else {
            _doctors.add(getDoctorResponse!);
          }
        }
        emit(BookAppointmentLoaded(
          loadedType: BookAppointmentBlocStateType.getServiceTimes,
        ));
        add(FilterServiceTimeByDay(selectedDay: DateTime.now()));
      }
    });

    on<FilterServiceTimeByDay>((event, emit) {
      emit(BookAppointmentLoading(
        loadingType: BookAppointmentBlocStateType.filterServiceTimes,
      ));
      _serviceTimeResponseFiltered.clear();
      _filteredDoctors.clear();
      for (int i = 0; i < _getServiceTimeResponse.length; i++) {
        if (_getServiceTimeResponse[i].state == "FreeServiceTimeState") {
          final date = DateTime.parse(_getServiceTimeResponse[i].date!);
          if (date.year == event.selectedDay.year &&
              date.month == event.selectedDay.month &&
              date.day == event.selectedDay.day) {
            _serviceTimeResponseFiltered.add(_getServiceTimeResponse[i]);
            _filteredDoctors.add(_doctors[i]);
          }
        }
      }
      emit(BookAppointmentLoaded(
        loadedType: BookAppointmentBlocStateType.filterServiceTimes,
      ));
    });
  }
}
