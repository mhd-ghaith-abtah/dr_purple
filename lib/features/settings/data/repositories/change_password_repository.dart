import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/settings/data/data_sources/change_password_remote_data_source.dart';
import 'package:dr_purple/features/settings/data/models/params/change_password/change_password_params.dart';
import 'package:dr_purple/features/settings/domain/entities/change_password_entity.dart';
import 'package:dr_purple/features/settings/domain/repositories/ichange_password_repository.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordRepository extends IChangePasswordRepository {
  final ChangePasswordRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ChangePasswordRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, ChangePasswordEntity>> changePassword(
      ChangePasswordParams changePasswordParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.changePassword(changePasswordParams);
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
        print("error while changing password: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.updateFailure());
    // }
  }
}
