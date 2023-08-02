import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/refresh/refresh_params.dart';
import 'package:dr_purple/features/auth/data/repositories/refresh_repository.dart';
import 'package:dr_purple/features/auth/domain/entities/refresh_entity.dart';

class RefreshUseCase extends UseCase<RefreshEntity, RefreshParams> {
  RefreshRepository repository;

  RefreshUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, RefreshEntity>> call(RefreshParams params) async =>
      repository.refresh(params);
}
