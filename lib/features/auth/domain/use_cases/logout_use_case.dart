import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/logout/logout_params.dart';
import 'package:dr_purple/features/auth/data/repositories/logout_repository.dart';
import 'package:dr_purple/features/auth/domain/entities/logout_entity.dart';

class LogoutUseCase extends UseCase<LogoutEntity, LogoutParams> {
  LogoutRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, LogoutEntity>> call(LogoutParams params) async =>
      repository.logout(params);
}
