import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_doctor/get_doctor_params.dart';
import 'package:dr_purple/features/home/data/repositories/get_doctor_repository.dart';
import 'package:dr_purple/features/home/domain/entities/get_doctor_entity.dart';

class GetDoctorUseCase extends UseCase<GetDoctorEntity, GetDoctorParams> {
  GetDoctorRepository repository;

  GetDoctorUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetDoctorEntity>> call(
          GetDoctorParams params) async =>
      repository.getDoctor(params);
}
