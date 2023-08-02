import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time/get_service_time_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_time_entity.dart';

abstract class IGetServiceTimeRepository extends IRepository {
  Future<Either<ErrorEntity, GetServiceTimeEntity>> getServiceTime(
      GetServiceTimeParams getServiceTimeParams);
}
