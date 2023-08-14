import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/notifications/data/remote/models/params/update_fcm_token_params/update_fcm_token_params.dart';
import 'package:dr_purple/features/notifications/data/remote/models/responses/update_fcm_token_response/update_fcm_token_api_response.dart';

abstract class IUpdateFCMTokenRemoteDataSource extends RemoteDataSource {
  IUpdateFCMTokenRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<UpdateFCMTokenAPIResponse> updateFCMToken(
      UpdateFCMTokenParams updateFCMTokenParams);
}

class UpdateFCMTokenRemoteDataSource extends IUpdateFCMTokenRemoteDataSource {
  UpdateFCMTokenRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<UpdateFCMTokenAPIResponse> updateFCMToken(
      UpdateFCMTokenParams updateFCMTokenParams) async {
    var res = await updateFCMTokenParams.requestType
        .getHTTPRequestType(this, updateFCMTokenParams);
    return Future.value(UpdateFCMTokenAPIResponse.fromJson(res));
  }
}
