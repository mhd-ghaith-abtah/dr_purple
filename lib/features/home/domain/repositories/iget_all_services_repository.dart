import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_services/get_all_services_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_services_entity.dart';

abstract class IGetAllServicesRepository extends IRepository {
  Future<Either<ErrorEntity, GetAllServicesEntity>> getAllServices(
      GetAllServicesParams getAllServicesParams);
}
