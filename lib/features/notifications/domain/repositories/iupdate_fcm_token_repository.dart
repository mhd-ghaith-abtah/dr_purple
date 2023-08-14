import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/notifications/data/remote/models/params/update_fcm_token_params/update_fcm_token_params.dart';
import 'package:dr_purple/features/notifications/domain/entities/update_fcm_token_entity.dart';

abstract class IUpdateFCMTokenRepository extends IRepository {
  Future<Either<ErrorEntity, UpdateFCMTokenEntity>> updateFCMToken(
      UpdateFCMTokenParams updateFCMTokenParams);
}
