import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/notifications/data/remote/models/params/update_fcm_token_params/update_fcm_token_params.dart';
import 'package:dr_purple/features/notifications/data/repositories/update_fcm_token_repository.dart';
import 'package:dr_purple/features/notifications/domain/entities/update_fcm_token_entity.dart';

class UpdateFCMTokenUseCase
    extends UseCase<UpdateFCMTokenEntity, UpdateFCMTokenParams> {
  UpdateFCMTokenRepository repository;

  UpdateFCMTokenUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, UpdateFCMTokenEntity>> call(
          UpdateFCMTokenParams params) async =>
      repository.updateFCMToken(params);
}
