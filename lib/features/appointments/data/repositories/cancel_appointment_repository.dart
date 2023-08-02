import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/appointments/data/remote/data_sources/cancel_appointment_remote_data_source.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/cancel_appointment/cancel_appointment_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/cancel_appointment_entity.dart';
import 'package:dr_purple/features/appointments/domain/repositories/icancel_appointment_repository.dart';
import 'package:flutter/foundation.dart';

class CancelAppointmentRepository extends ICancelAppointmentRepository {
  final CancelAppointmentRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  CancelAppointmentRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, CancelAppointmentEntity>> cancelAppointment(
      CancelAppointmentParams cancelAppointmentParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.cancelAppointment(cancelAppointmentParams);
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
        print("error while canceling appointment: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
