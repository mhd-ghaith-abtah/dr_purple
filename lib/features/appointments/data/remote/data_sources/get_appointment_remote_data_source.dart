import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_appointment/get_appointment_params.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/get_appointment_api_response/get_appointment_api_response.dart';

abstract class IGetAppointmentRemoteDataSource extends RemoteDataSource {
  IGetAppointmentRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetAppointmentAPIResponse> getAppointment(
      GetAppointmentParams getAppointmentParams);
}

class GetAppointmentRemoteDataSource extends IGetAppointmentRemoteDataSource {
  GetAppointmentRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetAppointmentAPIResponse> getAppointment(
      GetAppointmentParams getAppointmentParams) async {
    var res = await getAppointmentParams.requestType
        .getHTTPRequestType(this, getAppointmentParams);
    return Future.value(GetAppointmentAPIResponse.fromJson(res));
  }
}
