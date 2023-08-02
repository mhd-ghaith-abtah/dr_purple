part of 'book_appointment_bloc.dart';

@immutable
abstract class BookAppointmentState {}

class BookAppointmentInitial extends BookAppointmentState {}

class BookAppointmentLoading extends BookAppointmentState {
  final BookAppointmentBlocStateType loadingType;

  BookAppointmentLoading({required this.loadingType});
}

class BookAppointmentLoaded extends BookAppointmentState {
  final BookAppointmentBlocStateType loadedType;

  BookAppointmentLoaded({required this.loadedType});
}

class BookAppointmentError extends BookAppointmentState {
  final BookAppointmentBlocStateType errorType;
  final String errorMessage;

  BookAppointmentError({required this.errorType, required this.errorMessage});
}

enum BookAppointmentBlocStateType {
  selectService,
  selectServiceTime,
  getServiceTimes,
  filterServiceTimes,
  book
}
