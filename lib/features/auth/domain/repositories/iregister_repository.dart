import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/register/register_params.dart';
import 'package:dr_purple/features/auth/domain/entities/register_entity.dart';

abstract class IRegisterRepository extends IRepository {
  Future<Either<ErrorEntity, RegisterEntity>> register(
      RegisterParams registerParams);
}
