import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/data_sources/get_service_time_contract_remote_data_source.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time_contract/get_service_time_contract_params.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_time_contract_entity.dart';
import 'package:dr_purple/features/home/domain/repositories/iget_service_time_contract_repository.dart';
import 'package:flutter/foundation.dart';

class GetServiceTimeContractRepository
    extends IGetServiceTimeContractRepository {
  final GetServiceTimeContractRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetServiceTimeContractRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, GetServiceTimeContractEntity>>
      getServiceTimeContract(
          GetServiceTimeContractParams getServiceTimeContractParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response = await _remoteDataSource
          .getServiceTimeContract(getServiceTimeContractParams);
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
        print("error while getting service time contract: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
