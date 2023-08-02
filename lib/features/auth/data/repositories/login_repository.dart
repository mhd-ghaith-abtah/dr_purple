import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/login_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/login/login_params.dart';
import 'package:dr_purple/features/auth/domain/entities/login_entity.dart';
import 'package:dr_purple/features/auth/domain/repositories/ilogin_repository.dart';
import 'package:flutter/foundation.dart';

class LoginRepository extends ILoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  LoginRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, LoginEntity>> login(
      LoginParams loginParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response = await _remoteDataSource.login(loginParams);
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
        print("error while logging in: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
