import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_services/get_all_services_params.dart';
import 'package:dr_purple/features/home/data/repositories/get_all_services_repository.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_services_entity.dart';

class GetAllServicesUseCase
    extends UseCase<GetAllServicesEntity, GetAllServicesParams> {
  GetAllServicesRepository repository;

  GetAllServicesUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetAllServicesEntity>> call(
          GetAllServicesParams params) async =>
      repository.getAllServices(params);
}
