import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/settings/data/models/params/get_profile/get_profile_params.dart';
import 'package:dr_purple/features/settings/data/models/responses/get_profile_api_response/get_profile_api_response.dart';

abstract class IGetProfileRemoteDataSource extends RemoteDataSource {
  IGetProfileRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetProfileAPIResponse> getProfile(GetProfileParams getProfileParams);
}

class GetProfileRemoteDataSource extends IGetProfileRemoteDataSource {
  GetProfileRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetProfileAPIResponse> getProfile(
      GetProfileParams getProfileParams) async {
    var res = await getProfileParams.requestType
        .getHTTPRequestType(this, getProfileParams);
    return Future.value(GetProfileAPIResponse.fromJson(res));
  }
}
