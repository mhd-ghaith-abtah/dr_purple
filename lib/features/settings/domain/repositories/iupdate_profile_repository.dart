import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/settings/data/models/params/update_profile/update_profile_params.dart';
import 'package:dr_purple/features/settings/domain/entities/update_profile_entity.dart';

abstract class IUpdateProfileRepository extends IRepository {
  Future<Either<ErrorEntity, UpdateProfileEntity>> updateProfile(
      UpdateProfileParams updateProfileParams);
}
