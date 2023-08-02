import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/login/login_params.dart';
import 'package:dr_purple/features/auth/data/repositories/login_repository.dart';
import 'package:dr_purple/features/auth/domain/entities/login_entity.dart';

class LoginUseCase extends UseCase<LoginEntity, LoginParams> {
  LoginRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, LoginEntity>> call(LoginParams params) async =>
      repository.login(params);
}
