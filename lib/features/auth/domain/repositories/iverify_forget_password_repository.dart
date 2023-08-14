import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_forget_password/verify_forget_password_params.dart';
import 'package:dr_purple/features/auth/domain/entities/verify_forget_password_entity.dart';

abstract class IVerifyForgetPasswordRepository extends IRepository {
  Future<Either<ErrorEntity, VerifyForgetPasswordEntity>> verifyForgetPassword(
      VerifyForgetPasswordParams verifyForgetPasswordParams);
}
