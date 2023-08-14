import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/forget_password/forget_password_params.dart';
import 'package:dr_purple/features/auth/data/repositories/forget_password_repository.dart';
import 'package:dr_purple/features/auth/domain/entities/forget_password_entity.dart';

class ForgetPasswordUseCase
    extends UseCase<ForgetPasswordEntity, ForgetPasswordParams> {
  ForgetPasswordRepository repository;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, ForgetPasswordEntity>> call(
          ForgetPasswordParams params) async =>
      repository.forgetPassword(params);
}
