import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_contract/get_contract_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_contract_entity.dart';

abstract class IGetContractRepository extends IRepository {
  Future<Either<ErrorEntity, GetContractEntity>> getContract(
      GetContractParams getContractParams);
}
