import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/settings/data/models/params/get_profile/get_profile_params.dart';
import 'package:dr_purple/features/settings/domain/entities/get_profile_entity.dart';

abstract class IGetProfileRepository extends IRepository {
  Future<Either<ErrorEntity, GetProfileEntity>> getProfile(
      GetProfileParams getProfileParams);
}
