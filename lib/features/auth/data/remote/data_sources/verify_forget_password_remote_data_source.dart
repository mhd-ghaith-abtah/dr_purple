import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_forget_password/verify_forget_password_params.dart';
import 'package:dr_purple/features/auth/data/remote/models/responses/verify_forget_password_api_response/verify_forget_password_api_response.dart';

abstract class IVerifyForgetPasswordRemoteDataSource extends RemoteDataSource {
  IVerifyForgetPasswordRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<VerifyForgetPasswordAPIResponse> verifyForgetPassword(
      VerifyForgetPasswordParams verifyForgetPasswordParams);
}

class VerifyForgetPasswordRemoteDataSource
    extends IVerifyForgetPasswordRemoteDataSource {
  VerifyForgetPasswordRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<VerifyForgetPasswordAPIResponse> verifyForgetPassword(
      VerifyForgetPasswordParams verifyForgetPasswordParams) async {
    var res = await verifyForgetPasswordParams.requestType
        .getHTTPRequestType(this, verifyForgetPasswordParams);
    return Future.value(VerifyForgetPasswordAPIResponse.fromJson(res));
  }
}
