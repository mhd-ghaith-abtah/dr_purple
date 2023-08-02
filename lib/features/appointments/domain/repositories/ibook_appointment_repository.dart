import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/book_appointment/book_appointment_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/book_appointment_entity.dart';

abstract class IBookAppointmentRepository extends IRepository {
  Future<Either<ErrorEntity, BookAppointmentEntity>> bookAppointment(
      BookAppointmentParams bookAppointmentParams);
}
