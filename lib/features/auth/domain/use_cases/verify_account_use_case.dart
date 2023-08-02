import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_account/verify_account_params.dart';
import 'package:dr_purple/features/auth/data/repositories/verify_account_repository.dart';
import 'package:dr_purple/features/auth/domain/entities/verify_account_entity.dart';

class VerifyAccountUseCase
    extends UseCase<VerifyAccountEntity, VerifyAccountParams> {
  VerifyAccountRepository repository;

  VerifyAccountUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, VerifyAccountEntity>> call(
          VerifyAccountParams params) async =>
      repository.verifyAccount(params);
}
