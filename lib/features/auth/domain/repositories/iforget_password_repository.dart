import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/forget_password/forget_password_params.dart';
import 'package:dr_purple/features/auth/domain/entities/forget_password_entity.dart';

abstract class IForgetPasswordRepository extends IRepository {
  Future<Either<ErrorEntity, ForgetPasswordEntity>> forgetPassword(
      ForgetPasswordParams forgetPasswordParams);
}
