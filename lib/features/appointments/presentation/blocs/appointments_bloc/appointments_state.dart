part of 'appointments_bloc.dart';

@immutable
abstract class AppointmentsState {}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {
  final AppointmentsBlocStateType loadingType;

  AppointmentsLoading({required this.loadingType});
}

class AppointmentsLoaded extends AppointmentsState {
  final AppointmentsBlocStateType loadedType;

  AppointmentsLoaded({required this.loadedType});
}

class AppointmentsError extends AppointmentsState {
  final AppointmentsBlocStateType errorType;
  final String errorMessage;

  AppointmentsError({required this.errorType, required this.errorMessage});
}

enum AppointmentsBlocStateType { getMyAppointments }
