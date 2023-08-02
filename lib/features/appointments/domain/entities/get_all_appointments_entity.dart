import 'package:dr_purple/core/features/domain/entities/entity.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/get_all_appointments_api_response/get_all_appointments_api_response.dart';

class GetAllAppointmentsEntity extends Entity {
  final List<AppointmentModel>? appointments;

  GetAllAppointmentsEntity({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}
