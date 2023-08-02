import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/verify_account_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_account/verify_account_params.dart';
import 'package:dr_purple/features/auth/domain/entities/verify_account_entity.dart';
import 'package:dr_purple/features/auth/domain/repositories/iverify_account_repository.dart';
import 'package:flutter/foundation.dart';

class VerifyAccountRepository extends IVerifyAccountRepository {
  final VerifyAccountRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  VerifyAccountRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, VerifyAccountEntity>> verifyAccount(
      VerifyAccountParams verifyAccountParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.verifyAccount(verifyAccountParams);
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
        print("error while verifying Account: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
