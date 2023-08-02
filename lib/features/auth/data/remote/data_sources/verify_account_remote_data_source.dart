import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/verify_account/verify_account_params.dart';
import 'package:dr_purple/features/auth/data/remote/models/responses/verify_account_api_response/verify_account_api_response.dart';

abstract class IVerifyAccountRemoteDataSource extends RemoteDataSource {
  IVerifyAccountRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<VerifyAccountAPIResponse> verifyAccount(
      VerifyAccountParams verifyAccountParams);
}

class VerifyAccountRemoteDataSource extends IVerifyAccountRemoteDataSource {
  VerifyAccountRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<VerifyAccountAPIResponse> verifyAccount(
      VerifyAccountParams verifyAccountParams) async {
    var res = await verifyAccountParams.requestType
        .getHTTPRequestType(this, verifyAccountParams);
    return Future.value(VerifyAccountAPIResponse.fromJson(res));
  }
}
