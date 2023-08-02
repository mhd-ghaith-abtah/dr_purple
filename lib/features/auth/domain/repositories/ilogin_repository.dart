import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/login/login_params.dart';
import 'package:dr_purple/features/auth/domain/entities/login_entity.dart';

abstract class ILoginRepository extends IRepository {
  Future<Either<ErrorEntity, LoginEntity>> login(LoginParams loginParams);
}
