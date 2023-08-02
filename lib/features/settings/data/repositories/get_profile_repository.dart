import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/settings/data/data_sources/get_profile_remote_data_source.dart';
import 'package:dr_purple/features/settings/data/models/params/get_profile/get_profile_params.dart';
import 'package:dr_purple/features/settings/domain/entities/get_profile_entity.dart';
import 'package:dr_purple/features/settings/domain/repositories/iget_profile_repository.dart';
import 'package:flutter/foundation.dart';

class GetProfileRepository extends IGetProfileRepository {
  final GetProfileRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetProfileRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, GetProfileEntity>> getProfile(
      GetProfileParams getProfileParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response = await _remoteDataSource.getProfile(getProfileParams);
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
        print("error while getting profile: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
