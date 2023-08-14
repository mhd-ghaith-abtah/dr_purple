import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/settings/data/models/params/change_language/change_language_params.dart';
import 'package:dr_purple/features/settings/data/models/responses/change_language_api_response/change_language_api_response.dart';

abstract class IChangeLanguageRemoteDataSource extends RemoteDataSource {
  IChangeLanguageRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<ChangeLanguageAPIResponse> changeLanguage(
      ChangeLanguageParams changeLanguageParams);
}

class ChangeLanguageRemoteDataSource extends IChangeLanguageRemoteDataSource {
  ChangeLanguageRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<ChangeLanguageAPIResponse> changeLanguage(
      ChangeLanguageParams changeLanguageParams) async {
    var res = await changeLanguageParams.requestType
        .getHTTPRequestType(this, changeLanguageParams);
    return Future.value(ChangeLanguageAPIResponse.fromJson(res));
  }
}
