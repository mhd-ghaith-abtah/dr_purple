import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/logout_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/logout/logout_params.dart';
import 'package:dr_purple/features/auth/domain/entities/logout_entity.dart';
import 'package:dr_purple/features/auth/domain/repositories/ilogout_repository.dart';
import 'package:flutter/foundation.dart';

class LogoutRepository extends ILogoutRepository {
  final LogoutRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  LogoutRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, LogoutEntity>> logout(
      LogoutParams logoutParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response = await _remoteDataSource.logout(logoutParams);
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
        print("error while logging out: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
