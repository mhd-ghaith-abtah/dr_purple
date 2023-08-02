import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_appointment/get_appointment_params.dart';
import 'package:dr_purple/features/appointments/data/repositories/get_appointment_repository.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_appointment_entity.dart';

class GetAppointmentUseCase
    extends UseCase<GetAppointmentEntity, GetAppointmentParams> {
  GetAppointmentRepository repository;

  GetAppointmentUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetAppointmentEntity>> call(
          GetAppointmentParams params) async =>
      repository.getAppointment(params);
}
