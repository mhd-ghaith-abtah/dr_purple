import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/forget_password_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/forget_password/forget_password_params.dart';
import 'package:dr_purple/features/auth/domain/entities/forget_password_entity.dart';
import 'package:dr_purple/features/auth/domain/repositories/iforget_password_repository.dart';
import 'package:flutter/foundation.dart';

class ForgetPasswordRepository extends IForgetPasswordRepository {
  final ForgetPasswordRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ForgetPasswordRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, ForgetPasswordEntity>> forgetPassword(
      ForgetPasswordParams forgetPasswordParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.forgetPassword(forgetPasswordParams);
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
        print("error while sending forget password: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
