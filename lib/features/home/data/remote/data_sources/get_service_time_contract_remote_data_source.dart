import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_service_time_contract/get_service_time_contract_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_service_time_contract_api_response/get_service_time_contract_api_response.dart';

abstract class IGetServiceTimeContractRemoteDataSource
    extends RemoteDataSource {
  IGetServiceTimeContractRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetServiceTimeContractAPIResponse> getServiceTimeContract(
      GetServiceTimeContractParams getServiceTimeContractParams);
}

class GetServiceTimeContractRemoteDataSource
    extends IGetServiceTimeContractRemoteDataSource {
  GetServiceTimeContractRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetServiceTimeContractAPIResponse> getServiceTimeContract(
      GetServiceTimeContractParams getServiceTimeContractParams) async {
    var res = await getServiceTimeContractParams.requestType
        .getHTTPRequestType(this, getServiceTimeContractParams);
    return Future.value(GetServiceTimeContractAPIResponse.fromJson(res));
  }
}
