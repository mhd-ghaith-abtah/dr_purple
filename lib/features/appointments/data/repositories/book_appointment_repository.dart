import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/appointments/data/remote/data_sources/book_appointment_remote_data_source.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/book_appointment/book_appointment_params.dart';
import 'package:dr_purple/features/appointments/domain/entities/book_appointment_entity.dart';
import 'package:dr_purple/features/appointments/domain/repositories/ibook_appointment_repository.dart';
import 'package:flutter/foundation.dart';

class BookAppointmentRepository extends IBookAppointmentRepository {
  final BookAppointmentRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  BookAppointmentRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, BookAppointmentEntity>> bookAppointment(
      BookAppointmentParams bookAppointmentParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.bookAppointment(bookAppointmentParams);
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
        print("error while booking appointment: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
