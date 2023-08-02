import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/settings/data/models/params/get_profile/get_profile_params.dart';
import 'package:dr_purple/features/settings/data/repositories/get_profile_repository.dart';
import 'package:dr_purple/features/settings/domain/entities/get_profile_entity.dart';

class GetProfileUseCase extends UseCase<GetProfileEntity, GetProfileParams> {
  GetProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetProfileEntity>> call(
          GetProfileParams params) async =>
      repository.getProfile(params);
}
