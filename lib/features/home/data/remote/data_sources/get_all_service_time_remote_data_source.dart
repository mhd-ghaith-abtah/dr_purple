import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_service_time/get_all_service_time_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_service_time_api_response/get_all_service_time_api_response.dart';

abstract class IGetAllServiceTimeRemoteDataSource extends RemoteDataSource {
  IGetAllServiceTimeRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetAllServiceTimeAPIResponse> getAllServiceTime(
      GetAllServiceTimeParams getAllServiceTimeParams);
}

class GetAllServiceTimeRemoteDataSource
    extends IGetAllServiceTimeRemoteDataSource {
  GetAllServiceTimeRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetAllServiceTimeAPIResponse> getAllServiceTime(
      GetAllServiceTimeParams getAllServiceTimeParams) async {
    var res = await getAllServiceTimeParams.requestType
        .getHTTPRequestType(this, getAllServiceTimeParams);
    return Future.value(GetAllServiceTimeAPIResponse.fromJson(res));
  }
}
