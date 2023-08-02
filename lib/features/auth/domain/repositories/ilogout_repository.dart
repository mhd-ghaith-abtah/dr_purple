import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/logout/logout_params.dart';
import 'package:dr_purple/features/auth/domain/entities/logout_entity.dart';

abstract class ILogoutRepository extends IRepository {
  Future<Either<ErrorEntity, LogoutEntity>> logout(LogoutParams logoutParams);
}
