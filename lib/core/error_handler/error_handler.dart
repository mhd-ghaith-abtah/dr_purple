import 'package:dio/dio.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class ErrorHandler extends Equatable implements Exception {
  late ErrorEntity errorEntity;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      errorEntity = _handleError(error);
    } else if (error == DataSource.databaseError) {
      errorEntity = DataSource.databaseError.getFailure();
    } else if (error == DataSource.databaseNullError) {
      errorEntity = DataSource.databaseNullError.getFailure();
    } else if (error == DataSource.backgroundUploaderError) {
      errorEntity = DataSource.backgroundUploaderError.getFailure();
    } else {
      errorEntity = DataSource.unKnown.getFailure();
    }
  }

  ErrorEntity _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return ErrorEntity(
          statusCode: ResponseCode.connectionTimeout,
          message: ResponseMessage.connectionTimeout,
        );
      case DioErrorType.sendTimeout:
        return ErrorEntity(
          statusCode: ResponseCode.sendTimeout,
          message: ResponseMessage.sendTimeout,
        );
      case DioErrorType.receiveTimeout:
        return ErrorEntity(
          statusCode: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );
      case DioErrorType.badResponse:
        return error.response != null
            ? ErrorEntity(
                statusCode: error.response!.statusCode.numberOrZero(
                  number: ResponseCode.unKnown,
                ),
                message: error.response!.statusMessage.messageOrEmpty(
                  message: ResponseMessage.unKnown,
                ),
              )
            : DataSource.unKnown.getFailure();
      case DioErrorType.cancel:
        return ErrorEntity(
          statusCode: ResponseCode.cancel,
          message: ResponseMessage.cancel,
        );
      case DioErrorType.unknown:
        return ErrorEntity(
          statusCode: ResponseCode.unKnown,
          message: ResponseMessage.unKnown,
        );
      case DioErrorType.badCertificate:
        return ErrorEntity(
          statusCode: ResponseCode.badCertificate,
          message: ResponseMessage.unKnown,
        );
      case DioErrorType.connectionError:
        return ErrorEntity(
          statusCode: ResponseCode.connectionError,
          message: ResponseMessage.unKnown,
        );
    }
  }

  @override
  List<Object?> get props => [errorEntity.message, errorEntity.statusCode];
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  notFound,
  internalServerError,
  connectionTimeout,
  receiveTimeout,
  sendTimeout,
  cancel,
  cacheError,
  noInternetConnection,
  unKnown,
  databaseError,
  databaseNullError,
  backgroundUploaderError,
}

extension DataSourceExtension on DataSource {
  ErrorEntity getFailure() {
    switch (this) {
      case DataSource.success:
        return ErrorEntity(
          statusCode: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case DataSource.noContent:
        return ErrorEntity(
          statusCode: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        );
      case DataSource.badRequest:
        return ErrorEntity(
          statusCode: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return ErrorEntity(
          statusCode: ResponseCode.forbidden,
          message: ResponseMessage.forbidden,
        );
      case DataSource.unAuthorized:
        return ErrorEntity(
          statusCode: ResponseCode.unAuthorized,
          message: ResponseMessage.unAuthorized,
        );
      case DataSource.notFound:
        return ErrorEntity(
          statusCode: ResponseCode.notFound,
          message: ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return ErrorEntity(
          statusCode: ResponseCode.internalServerError,
          message: ResponseMessage.internalServerError,
        );
      case DataSource.connectionTimeout:
        return ErrorEntity(
          statusCode: ResponseCode.connectionTimeout,
          message: ResponseMessage.connectionTimeout,
        );
      case DataSource.receiveTimeout:
        return ErrorEntity(
          statusCode: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeout:
        return ErrorEntity(
          statusCode: ResponseCode.sendTimeout,
          message: ResponseMessage.sendTimeout,
        );
      case DataSource.cancel:
        return ErrorEntity(
          statusCode: ResponseCode.cancel,
          message: ResponseMessage.cancel,
        );
      case DataSource.cacheError:
        return ErrorEntity(
          statusCode: ResponseCode.cacheError,
          message: ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return ErrorEntity(
          statusCode: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        );
      case DataSource.unKnown:
        return ErrorEntity(
          statusCode: ResponseCode.unKnown,
          message: ResponseMessage.unKnown,
        );
      case DataSource.databaseError:
        return ErrorEntity(
          statusCode: ResponseCode.databaseError,
          message: ResponseMessage.databaseError,
        );
      case DataSource.databaseNullError:
        return ErrorEntity(
          statusCode: ResponseCode.databaseNullError,
          message: ResponseMessage.databaseNullError,
        );
      case DataSource.backgroundUploaderError:
        return ErrorEntity(
          statusCode: ResponseCode.backgroundUploaderError,
          message: ResponseMessage.backgroundUploaderError,
        );
    }
  }
}

class ResponseCode {
  static const success = 200;
  static const noContent = 201;
  static const badRequest = 400;
  static const unAuthorized = 401;
  static const forbidden = 403;
  static const notFound = 404;
  static const badCertificate = 495;
  static const internalServerError = 500;
  static const connectionError = 502;

  /// local status code
  static const connectionTimeout = -1;
  static const cancel = -2;
  static const receiveTimeout = -3;
  static const sendTimeout = -4;
  static const cacheError = -5;
  static const noInternetConnection = -6;
  static const unKnown = -7;
  static const databaseError = -8;
  static const databaseNullError = -9;
  static const backgroundUploaderError = -10;
}

class ResponseMessage {
  static String success = AppStrings.success.tr();
  static String noContent = AppStrings.noContent.tr();
  static String badRequest = AppStrings.badRequest.tr();
  static String unAuthorized = AppStrings.unAuthorized.tr();
  static String forbidden = AppStrings.forbidden.tr();
  static String notFound = AppStrings.notFound.tr();
  static String internalServerError = AppStrings.internalServerError.tr();

  /// local status code
  static String connectionTimeout = AppStrings.connectionTimeout.tr();
  static String cancel = AppStrings.cancel.tr();
  static String receiveTimeout = AppStrings.receiveTimeout.tr();
  static String sendTimeout = AppStrings.sendTimeout.tr();
  static String cacheError = AppStrings.cacheError.tr();
  static String noInternetConnection = AppStrings.noInternetConnection.tr();
  static String unKnown = AppStrings.unKnown.tr();
  static String databaseError = AppStrings.databaseError.tr();
  static String databaseNullError = AppStrings.databaseNullError.tr();
  static String backgroundUploaderError =
      AppStrings.backgroundUploaderError.tr();
}
