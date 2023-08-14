import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/settings/data/models/params/change_password/change_password_params.dart';
import 'package:dr_purple/features/settings/data/models/responses/change_password_api_response/change_password_api_response.dart';

abstract class IChangePasswordRemoteDataSource extends RemoteDataSource {
  IChangePasswordRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<ChangePasswordAPIResponse> changePassword(
      ChangePasswordParams changePasswordParams);
}

class ChangePasswordRemoteDataSource extends IChangePasswordRemoteDataSource {
  ChangePasswordRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<ChangePasswordAPIResponse> changePassword(
      ChangePasswordParams changePasswordParams) async {
    var res = await changePasswordParams.requestType
        .getHTTPRequestType(this, changePasswordParams);
    return Future.value(ChangePasswordAPIResponse.fromJson(res));
  }
}
