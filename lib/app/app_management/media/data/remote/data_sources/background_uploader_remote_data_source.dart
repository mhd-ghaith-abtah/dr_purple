import 'package:dr_purple/app/app_management/media/data/remote/models/params/media_upload_params.dart';
import 'package:dr_purple/app/app_management/media/data/remote/models/responses/background_uploader_response/background_uploader_response.dart';
import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';

abstract class IBackgroundUploaderRemoteDataSource extends RemoteDataSource {
  IBackgroundUploaderRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<BackgroundUploaderResponse> enqueueFile(
      MediaUploadParams mediaUploadParams);
}

class BackgroundUploaderRemoteDataSource
    extends IBackgroundUploaderRemoteDataSource {
  BackgroundUploaderRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<BackgroundUploaderResponse> enqueueFile(
      MediaUploadParams mediaUploadParams) async {
    var res = await mediaUploadParams.requestType
        .getHTTPRequestType(this, mediaUploadParams);
    return Future.value(BackgroundUploaderResponse.fromJson(res));
  }
}
