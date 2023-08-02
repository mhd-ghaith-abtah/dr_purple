import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_doctor/get_doctor_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_doctor_entity.dart';

abstract class IGetDoctorRepository extends IRepository {
  Future<Either<ErrorEntity, GetDoctorEntity>> getDoctor(
      GetDoctorParams getDoctorParams);
}
