import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/appointments/data/remote/data_sources/get_appointment_remote_data_source.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_appointment/get_appointment_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_appointment_entity.dart';
import 'package:dr_purple/features/appointments/domain/repositories/iget_appointment_repository.dart';
import 'package:flutter/foundation.dart';

class GetAppointmentRepository extends IGetAppointmentRepository {
  final GetAppointmentRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetAppointmentRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, GetAppointmentEntity>> getAppointment(
      GetAppointmentParams getAppointmentParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.getAppointment(getAppointmentParams);
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
        print("error while getting appointment: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
