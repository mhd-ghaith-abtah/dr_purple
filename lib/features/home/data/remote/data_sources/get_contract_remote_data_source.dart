import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_contract/get_contract_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_contract_api_response/get_contract_api_response.dart';

abstract class IGetContractRemoteDataSource extends RemoteDataSource {
  IGetContractRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetContractAPIResponse> getContract(
      GetContractParams getContractParams);
}

class GetContractRemoteDataSource extends IGetContractRemoteDataSource {
  GetContractRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetContractAPIResponse> getContract(
      GetContractParams getContractParams) async {
    var res = await getContractParams.requestType
        .getHTTPRequestType(this, getContractParams);
    return Future.value(GetContractAPIResponse.fromJson(res));
  }
}
