import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/register/register_params.dart';
import 'package:dr_purple/features/auth/data/repositories/register_repository.dart';
import 'package:dr_purple/features/auth/domain/entities/register_entity.dart';

class RegisterUseCase extends UseCase<RegisterEntity, RegisterParams> {
  RegisterRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, RegisterEntity>> call(
          RegisterParams params) async =>
      repository.register(params);
}
