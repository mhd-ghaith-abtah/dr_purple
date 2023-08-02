import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/register_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/register/register_params.dart';
import 'package:dr_purple/features/auth/domain/entities/register_entity.dart';
import 'package:dr_purple/features/auth/domain/repositories/iregister_repository.dart';
import 'package:flutter/foundation.dart';

class RegisterRepository extends IRegisterRepository {
  final RegisterRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RegisterRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, RegisterEntity>> register(
      RegisterParams registerParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response = await _remoteDataSource.register(registerParams);
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
        print("error while registering: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
