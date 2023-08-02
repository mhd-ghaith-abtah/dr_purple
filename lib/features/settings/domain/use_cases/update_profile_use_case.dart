import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/settings/data/models/params/update_profile/update_profile_params.dart';
import 'package:dr_purple/features/settings/data/repositories/update_profile_repository.dart';
import 'package:dr_purple/features/settings/domain/entities/update_profile_entity.dart';

class UpdateProfileUseCase extends UseCase<UpdateProfileEntity, UpdateProfileParams> {
  UpdateProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, UpdateProfileEntity>> call(
      UpdateProfileParams params) async =>
      repository.updateProfile(params);
}
