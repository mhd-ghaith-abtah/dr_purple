import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/settings/data/models/params/change_password/change_password_params.dart';
import 'package:dr_purple/features/settings/domain/entities/change_password_entity.dart';

abstract class IChangePasswordRepository extends IRepository {
  Future<Either<ErrorEntity, ChangePasswordEntity>> changePassword(
      ChangePasswordParams changePasswordParams);
}
