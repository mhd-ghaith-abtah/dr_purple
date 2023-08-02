import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service/get_service_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_service_api_response/get_service_api_response.dart';

abstract class IGetServiceRemoteDataSource extends RemoteDataSource {
  IGetServiceRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetServiceAPIResponse> getService(GetServiceParams getServiceParams);
}

class GetServiceRemoteDataSource extends IGetServiceRemoteDataSource {
  GetServiceRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetServiceAPIResponse> getService(
      GetServiceParams getServiceParams) async {
    var res = await getServiceParams.requestType
        .getHTTPRequestType(this, getServiceParams);
    return Future.value(GetServiceAPIResponse.fromJson(res));
  }
}
