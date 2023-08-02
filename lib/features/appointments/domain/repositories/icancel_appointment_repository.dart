import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/cancel_appointment/cancel_appointment_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/cancel_appointment_entity.dart';

abstract class ICancelAppointmentRepository extends IRepository {
  Future<Either<ErrorEntity, CancelAppointmentEntity>> cancelAppointment(
      CancelAppointmentParams cancelAppointmentParams);
}
