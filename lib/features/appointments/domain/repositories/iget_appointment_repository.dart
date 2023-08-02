import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_appointment/get_appointment_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_appointment_entity.dart';

abstract class IGetAppointmentRepository extends IRepository {
  Future<Either<ErrorEntity, GetAppointmentEntity>> getAppointment(
      GetAppointmentParams getAppointmentParams);
}
