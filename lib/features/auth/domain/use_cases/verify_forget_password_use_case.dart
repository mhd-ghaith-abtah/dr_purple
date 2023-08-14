import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_forget_password/verify_forget_password_params.dart';
import 'package:dr_purple/features/auth/data/repositories/verify_forget_password_repository.dart';
import 'package:dr_purple/features/auth/domain/entities/verify_forget_password_entity.dart';

class VerifyForgetPasswordUseCase
    extends UseCase<VerifyForgetPasswordEntity, VerifyForgetPasswordParams> {
  VerifyForgetPasswordRepository repository;

  VerifyForgetPasswordUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, VerifyForgetPasswordEntity>> call(
          VerifyForgetPasswordParams params) async =>
      repository.verifyForgetPassword(params);
}
