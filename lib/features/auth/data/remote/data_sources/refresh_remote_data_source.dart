import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/refresh/refresh_params.dart';
import 'package:dr_purple/features/auth/data/remote/models/responses/refresh_api_response/refresh_api_response.dart';

abstract class IRefreshRemoteDataSource extends RemoteDataSource {
  IRefreshRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<RefreshAPIResponse> refresh(RefreshParams refreshParams);
}

class RefreshRemoteDataSource extends IRefreshRemoteDataSource {
  RefreshRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<RefreshAPIResponse> refresh(RefreshParams refreshParams) async {
    var res =
        await refreshParams.requestType.getHTTPRequestType(this, refreshParams);
    return Future.value(RefreshAPIResponse.fromJson(res));
  }
}
