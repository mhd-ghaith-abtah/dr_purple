import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service/get_service_params.dart';
import 'package:dr_purple/features/home/data/repositories/get_service_repository.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_entity.dart';

class GetServiceUseCase extends UseCase<GetServiceEntity, GetServiceParams> {
  GetServiceRepository repository;

  GetServiceUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetServiceEntity>> call(
      GetServiceParams params) async =>
      repository.getService(params);
}