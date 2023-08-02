import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time_contract/get_service_time_contract_params.dart';
import 'package:dr_purple/features/home/data/repositories/get_service_time_contract_repository.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_time_contract_entity.dart';

class GetServiceTimeContractUseCase extends UseCase<
    GetServiceTimeContractEntity, GetServiceTimeContractParams> {
  GetServiceTimeContractRepository repository;

  GetServiceTimeContractUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetServiceTimeContractEntity>> call(
          GetServiceTimeContractParams params) async =>
      repository.getServiceTimeContract(params);
}
