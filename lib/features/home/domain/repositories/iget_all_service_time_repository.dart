import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_service_time/get_all_service_time_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_service_time_entity.dart';

abstract class IGetAllServiceTimeRepository extends IRepository {
  Future<Either<ErrorEntity, GetAllServiceTimeEntity>> getAllServiceTime(
      GetAllServiceTimeParams getAllServiceTimeParams);
}
