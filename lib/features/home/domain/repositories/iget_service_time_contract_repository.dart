import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time_contract/get_service_time_contract_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_time_contract_entity.dart';

abstract class IGetServiceTimeContractRepository extends IRepository {
  Future<Either<ErrorEntity, GetServiceTimeContractEntity>>
      getServiceTimeContract(
          GetServiceTimeContractParams getServiceTimeContractParams);
}
