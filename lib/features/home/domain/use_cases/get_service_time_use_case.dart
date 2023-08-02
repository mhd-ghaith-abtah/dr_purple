
import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time/get_service_time_params.dart';
import 'package:dr_purple/features/home/data/repositories/get_service_time_repository.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_time_entity.dart';

class GetServiceTimeUseCase
    extends UseCase<GetServiceTimeEntity, GetServiceTimeParams> {
  GetServiceTimeRepository repository;

  GetServiceTimeUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetServiceTimeEntity>> call(
      GetServiceTimeParams params) async =>
      repository.getServiceTime(params);
}
