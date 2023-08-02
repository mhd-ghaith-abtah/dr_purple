import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_all_appointments/get_all_appointments_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_all_appointments_entity.dart';

abstract class IGetAllAppointmentsRepository extends IRepository {
  Future<Either<ErrorEntity, GetAllAppointmentsEntity>> getAllAppointments(
      GetAllAppointmentsParams getAllAppointmentsParams);
}
