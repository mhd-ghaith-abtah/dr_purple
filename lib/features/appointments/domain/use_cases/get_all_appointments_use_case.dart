import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_all_appointments/get_all_appointments_params.dart';
import 'package:dr_purple/features/appointments/data/repositories/get_all_appointments_repository.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_all_appointments_entity.dart';

class GetAllAppointmentsUseCase
    extends UseCase<GetAllAppointmentsEntity, GetAllAppointmentsParams> {
  GetAllAppointmentsRepository repository;

  GetAllAppointmentsUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetAllAppointmentsEntity>> call(
          GetAllAppointmentsParams params) async =>
      repository.getAllAppointments(params);
}
