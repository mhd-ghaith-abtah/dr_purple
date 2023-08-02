import 'package:dartz/dartz.dart';
import 'package:dr_purple/app/app_management/media/data/remote/data_sources/background_uploader_remote_data_source.dart';
import 'package:dr_purple/app/app_management/media/data/remote/models/params/media_upload_params.dart';
import 'package:dr_purple/app/app_management/media/domain/entities/background_uploader_entity.dart';
import 'package:dr_purple/app/app_management/media/domain/repositories/ibackground_uploader_repository.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:flutter/foundation.dart';

class BackgroundUploaderRepository extends IBackgroundUploaderRepository {
  final BackgroundUploaderRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  BackgroundUploaderRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<ErrorEntity, BackgroundUploaderEntity>> enqueueFile(
      MediaUploadParams mediaUploadParams) async {
    // if (await _networkInfo.isConnected) {
    try {
      final response = await _remoteDataSource.enqueueFile(mediaUploadParams);
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
        print("error while uploading file to server: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(e).errorEntity);
    }
    // } else {
    //   return Left(DataSource.noInternetConnection.getFailure());
    // }
  }
}
