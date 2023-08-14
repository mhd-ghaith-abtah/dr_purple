import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/settings/data/models/params/change_password/change_password_params.dart';
import 'package:dr_purple/features/settings/data/repositories/change_password_repository.dart';
import 'package:dr_purple/features/settings/domain/entities/change_password_entity.dart';

class ChangePasswordUseCase
    extends UseCase<ChangePasswordEntity, ChangePasswordParams> {
  ChangePasswordRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, ChangePasswordEntity>> call(
          ChangePasswordParams params) async =>
      repository.changePassword(params);
}
