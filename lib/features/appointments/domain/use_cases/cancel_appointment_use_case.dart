import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/cancel_appointment/cancel_appointment_params.dart';
import 'package:dr_purple/features/appointments/data/repositories/cancel_appointment_repository.dart';
import 'package:dr_purple/features/appointments/domain/entities/cancel_appointment_entity.dart';

class CancelAppointmentUseCase
    extends UseCase<CancelAppointmentEntity, CancelAppointmentParams> {
  CancelAppointmentRepository repository;

  CancelAppointmentUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, CancelAppointmentEntity>> call(
          CancelAppointmentParams params) async =>
      repository.cancelAppointment(params);
}
