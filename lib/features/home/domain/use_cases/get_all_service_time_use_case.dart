import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_service_time/get_all_service_time_params.dart';
import 'package:dr_purple/features/home/data/repositories/get_all_service_time_repository.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_service_time_entity.dart';

class GetAllServiceTimeUseCase
    extends UseCase<GetAllServiceTimeEntity, GetAllServiceTimeParams> {
  GetAllServiceTimeRepository repository;

  GetAllServiceTimeUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetAllServiceTimeEntity>> call(
          GetAllServiceTimeParams params) async =>
      repository.getAllServiceTime(params);
}
