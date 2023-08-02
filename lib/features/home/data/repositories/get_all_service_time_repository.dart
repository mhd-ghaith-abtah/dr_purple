import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/data_sources/get_all_service_time_remote_data_source.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_service_time/get_all_service_time_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_service_time_entity.dart';
import 'package:dr_purple/features/home/domain/repositories/iget_all_service_time_repository.dart';
import 'package:flutter/foundation.dart';

class GetAllServiceTimeRepository extends IGetAllServiceTimeRepository {
  final GetAllServiceTimeRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetAllServiceTimeRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, GetAllServiceTimeEntity>> getAllServiceTime(
      GetAllServiceTimeParams getAllServiceTimeParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.getAllServiceTime(getAllServiceTimeParams);
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
        print("error while getting all service time: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
