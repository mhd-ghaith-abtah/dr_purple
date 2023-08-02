import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/login/login_params.dart';
import 'package:dr_purple/features/auth/data/remote/models/responses/login_api_response/login_api_response.dart';

abstract class ILoginRemoteDataSource extends RemoteDataSource {
  ILoginRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<LoginAPIResponse> login(LoginParams loginParams);
}

class LoginRemoteDataSource extends ILoginRemoteDataSource {
  LoginRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<LoginAPIResponse> login(LoginParams loginParams) async {
    var res =
        await loginParams.requestType.getHTTPRequestType(this, loginParams);
    return Future.value(LoginAPIResponse.fromJson(res));
  }
}
