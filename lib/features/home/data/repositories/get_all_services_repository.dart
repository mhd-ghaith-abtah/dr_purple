import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/data_sources/get_all_services_remote_data_source.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_services/get_all_services_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_services_entity.dart';
import 'package:dr_purple/features/home/domain/repositories/iget_all_services_repository.dart';
import 'package:flutter/foundation.dart';

class GetAllServicesRepository extends IGetAllServicesRepository {
  final GetAllServicesRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetAllServicesRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, GetAllServicesEntity>> getAllServices(
      GetAllServicesParams getAllServicesParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.getAllServices(getAllServicesParams);
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
        print("error while getting all services: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
