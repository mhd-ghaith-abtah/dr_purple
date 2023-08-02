import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_services/get_all_services_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_services_api_response/get_all_services_api_response.dart';

abstract class IGetAllServicesRemoteDataSource extends RemoteDataSource {
  IGetAllServicesRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetAllServicesAPIResponse> getAllServices(
      GetAllServicesParams getAllServicesParams);
}

class GetAllServicesRemoteDataSource extends IGetAllServicesRemoteDataSource {
  GetAllServicesRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetAllServicesAPIResponse> getAllServices(
      GetAllServicesParams getAllServicesParams) async {
    var res = await getAllServicesParams.requestType
        .getHTTPRequestType(this, getAllServicesParams);
    return Future.value(GetAllServicesAPIResponse.fromJson(res));
  }
}
