import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/settings/data/data_sources/change_language_remote_data_source.dart';
import 'package:dr_purple/features/settings/data/models/params/change_language/change_language_params.dart';
import 'package:dr_purple/features/settings/domain/entities/change_language_entity.dart';
import 'package:dr_purple/features/settings/domain/repositories/ichange_language_repository.dart';
import 'package:flutter/foundation.dart';

class ChangeLanguageRepository extends IChangeLanguageRepository {
  final ChangeLanguageRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ChangeLanguageRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, ChangeLanguageEntity>> changeLanguage(
      ChangeLanguageParams changeLanguageParams) async {
    //if (await _networkInfo.isConnected) {
    try {
      final response =
          await _remoteDataSource.changeLanguage(changeLanguageParams);
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
        print("error while changing language: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.updateFailure());
    // }
  }
}
