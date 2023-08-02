import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/settings/data/models/params/update_profile/update_profile_params.dart';
import 'package:dr_purple/features/settings/data/models/responses/update_profile_api_response/update_profile_api_response.dart';

abstract class IUpdateProfileRemoteDataSource extends RemoteDataSource {
  IUpdateProfileRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<UpdateProfileAPIResponse> updateProfile(
      UpdateProfileParams updateProfileParams);
}

class UpdateProfileRemoteDataSource extends IUpdateProfileRemoteDataSource {
  UpdateProfileRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<UpdateProfileAPIResponse> updateProfile(
      UpdateProfileParams updateProfileParams) async {
    var res = await updateProfileParams.requestType
        .getHTTPRequestType(this, updateProfileParams);
    return Future.value(UpdateProfileAPIResponse.fromJson(res));
  }
}
