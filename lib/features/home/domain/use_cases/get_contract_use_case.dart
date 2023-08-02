import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_contract/get_contract_params.dart';
import 'package:dr_purple/features/home/data/repositories/get_contract_repository.dart';
import 'package:dr_purple/features/home/domain/entities/get_contract_entity.dart';

class GetContractUseCase extends UseCase<GetContractEntity, GetContractParams> {
  GetContractRepository repository;

  GetContractUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetContractEntity>> call(
          GetContractParams params) async =>
      repository.getContract(params);
}
