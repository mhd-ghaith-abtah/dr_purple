import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/logout/logout_params.dart';
import 'package:dr_purple/features/auth/data/remote/models/responses/logout_api_response/logout_api_response.dart';

abstract class ILogoutRemoteDataSource extends RemoteDataSource {
  ILogoutRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<LogoutAPIResponse> logout(LogoutParams logoutParams);
}

class LogoutRemoteDataSource extends ILogoutRemoteDataSource {
  LogoutRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<LogoutAPIResponse> logout(LogoutParams logoutParams) async {
    var res =
        await logoutParams.requestType.getHTTPRequestType(this, logoutParams);
    return Future.value(LogoutAPIResponse.fromJson(res));
  }
}
