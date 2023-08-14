import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/forget_password/forget_password_params.dart';
import 'package:dr_purple/features/auth/data/remote/models/responses/forget_password_api_response/forget_password_api_response.dart';

abstract class IForgetPasswordRemoteDataSource extends RemoteDataSource {
  IForgetPasswordRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<ForgetPasswordAPIResponse> forgetPassword(
      ForgetPasswordParams forgetPasswordParams);
}

class ForgetPasswordRemoteDataSource extends IForgetPasswordRemoteDataSource {
  ForgetPasswordRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<ForgetPasswordAPIResponse> forgetPassword(
      ForgetPasswordParams forgetPasswordParams) async {
    var res = await forgetPasswordParams.requestType
        .getHTTPRequestType(this, forgetPasswordParams);
    return Future.value(ForgetPasswordAPIResponse.fromJson(res));
  }
}
