import 'package:dio/dio.dart';
import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/storage/app_preferences.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Dio getDio() {
    Dio dio = Dio();

    Map<String, String?> headers = {
      Constants.contentType: Constants.applicationJson,
      Constants.accept: Constants.applicationJson,
      Constants.authorization: _appPreferences.getAccessToken(),
    };

    dio.options = BaseOptions(
      baseUrl: AppConfigurations.baseUrl,
      headers: headers,
      responseType: ResponseType.json,
      receiveTimeout: AppDurations.timeout,
      sendTimeout: AppDurations.timeout,
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
