part of 'appointments_bloc.dart';

@immutable
abstract class AppointmentsEvent {}

class GetMyAppointments extends AppointmentsEvent {}

class CancelAppointmentEvent extends AppointmentsEvent {
  final int id;

  CancelAppointmentEvent({required this.id});
}
