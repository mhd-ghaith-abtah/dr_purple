import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_account/verify_account_params.dart';
import 'package:dr_purple/features/auth/domain/entities/verify_account_entity.dart';

abstract class IVerifyAccountRepository extends IRepository {
  Future<Either<ErrorEntity, VerifyAccountEntity>> verifyAccount(
      VerifyAccountParams verifyAccountParams);
}
