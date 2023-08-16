import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/pharmacy/data/remote/data_sources/pharmacy_remote_data_source.dart';
import 'package:dr_purple/features/pharmacy/data/remote/models/params/pharmacy/pharmacy_params.dart';
import 'package:dr_purple/features/pharmacy/domain/entities/pharmacy_entity.dart';
import 'package:dr_purple/features/pharmacy/domain/repositories/ipharmacy_repository.dart';
import 'package:flutter/foundation.dart';

class PharmacyRepository extends IPharmacyRepository {
  final PharmacyRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  PharmacyRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, PharmacyEntity>> getPharmacy(
      PharmacyParams pharmacyParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response = await _remoteDataSource.getPharmacy(pharmacyParams);
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
        print("error while getting pharmacy: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
