import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/book_appointment/book_appointment_params.dart';
import 'package:dr_purple/features/appointments/data/repositories/book_appointment_repository.dart';
import 'package:dr_purple/features/appointments/domain/entities/book_appointment_entity.dart';

class BookAppointmentUseCase
    extends UseCase<BookAppointmentEntity, BookAppointmentParams> {
  BookAppointmentRepository repository;

  BookAppointmentUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, BookAppointmentEntity>> call(
          BookAppointmentParams params) async =>
      repository.bookAppointment(params);
}
