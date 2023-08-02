part of 'book_appointment_bloc.dart';

@immutable
abstract class BookAppointmentEvent {}

class SelectService extends BookAppointmentEvent {
  final int serviceId;

  SelectService({required this.serviceId});
}

class SelectServiceTime extends BookAppointmentEvent {
  final int serviceTimeId;

  SelectServiceTime({required this.serviceTimeId});
}

class GetServiceTimes extends BookAppointmentEvent {}

class BookAppointment extends BookAppointmentEvent {}

class FilterServiceTimeByDay extends BookAppointmentEvent {
  final DateTime selectedDay;

  FilterServiceTimeByDay({required this.selectedDay});
}
