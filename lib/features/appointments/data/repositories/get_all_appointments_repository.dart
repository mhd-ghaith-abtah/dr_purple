import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/appointments/data/remote/data_sources/get_all_appointments_remote_data_source.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_all_appointments/get_all_appointments_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_all_appointments_entity.dart';
import 'package:dr_purple/features/appointments/domain/repositories/iget_all_appointments_repository.dart';
import 'package:flutter/foundation.dart';

class GetAllAppointmentsRepository extends IGetAllAppointmentsRepository {
  final GetAllAppointmentsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GetAllAppointmentsRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, GetAllAppointmentsEntity>> getAllAppointments(
      GetAllAppointmentsParams getAllAppointmentsParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.getAllAppointments(getAllAppointmentsParams);
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
        print("error while getting all appointments: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
