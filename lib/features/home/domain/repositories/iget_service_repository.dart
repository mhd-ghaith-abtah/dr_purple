import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service/get_service_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_entity.dart';

abstract class IGetServiceRepository extends IRepository {
  Future<Either<ErrorEntity, GetServiceEntity>> getService(
      GetServiceParams getServiceParams);
}
