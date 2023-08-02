import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time/get_service_time_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_service_time_api_response/get_service_time_api_response.dart';

abstract class IGetServiceTimeRemoteDataSource extends RemoteDataSource {
  IGetServiceTimeRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetServiceTimeAPIResponse> getServiceTime(
      GetServiceTimeParams getServiceTimeParams);
}

class GetServiceTimeRemoteDataSource extends IGetServiceTimeRemoteDataSource {
  GetServiceTimeRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetServiceTimeAPIResponse> getServiceTime(
      GetServiceTimeParams getServiceTimeParams) async {
    var res = await getServiceTimeParams.requestType
        .getHTTPRequestType(this, getServiceTimeParams);
    return Future.value(GetServiceTimeAPIResponse.fromJson(res));
  }
}
