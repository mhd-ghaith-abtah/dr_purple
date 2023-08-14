import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/notifications/data/remote/data_sources/update_fcm_token_remote_data_source.dart';
import 'package:dr_purple/features/notifications/data/remote/models/params/update_fcm_token_params/update_fcm_token_params.dart';
import 'package:dr_purple/features/notifications/domain/entities/update_fcm_token_entity.dart';
import 'package:dr_purple/features/notifications/domain/repositories/iupdate_fcm_token_repository.dart';
import 'package:flutter/foundation.dart';

class UpdateFCMTokenRepository extends IUpdateFCMTokenRepository {
  final UpdateFCMTokenRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  UpdateFCMTokenRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, UpdateFCMTokenEntity>> updateFCMToken(
      UpdateFCMTokenParams updateFCMTokenParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.updateFCMToken(updateFCMTokenParams);
      if (response.succsess ?? false) {
        return Right(response.toEntity());
      } else {
        return Left(
          ErrorEntity(
            statusCode:
                response.messageId!.numberOrZero(number: Constants.zero),
            message: response.message.messageOrEmpty(
              message: response.message.messageOrEmpty(
                message: ResponseMessage.unKnown,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("error while updating fcm token: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
