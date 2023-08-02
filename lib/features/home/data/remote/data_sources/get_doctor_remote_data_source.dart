import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_doctor/get_doctor_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_doctor_api_response/get_doctor_api_response.dart';

abstract class IGetDoctorRemoteDataSource extends RemoteDataSource {
  IGetDoctorRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetDoctorAPIResponse> getDoctor(GetDoctorParams getDoctorParams);
}

class GetDoctorRemoteDataSource extends IGetDoctorRemoteDataSource {
  GetDoctorRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetDoctorAPIResponse> getDoctor(
      GetDoctorParams getDoctorParams) async {
    var res = await getDoctorParams.requestType
        .getHTTPRequestType(this, getDoctorParams);
    return Future.value(GetDoctorAPIResponse.fromJson(res));
  }
}
