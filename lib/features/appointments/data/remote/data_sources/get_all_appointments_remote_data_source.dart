import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/get_all_appointments/get_all_appointments_params.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/get_all_appointments_api_response/get_all_appointments_api_response.dart';

abstract class IGetAllAppointmentsRemoteDataSource extends RemoteDataSource {
  IGetAllAppointmentsRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<GetAllAppointmentsAPIResponse> getAllAppointments(
      GetAllAppointmentsParams getAllAppointmentsParams);
}

class GetAllAppointmentsRemoteDataSource
    extends IGetAllAppointmentsRemoteDataSource {
  GetAllAppointmentsRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<GetAllAppointmentsAPIResponse> getAllAppointments(
      GetAllAppointmentsParams getAllAppointmentsParams) async {
    var res = await getAllAppointmentsParams.requestType
        .getHTTPRequestType(this, getAllAppointmentsParams);
    return Future.value(GetAllAppointmentsAPIResponse.fromJson(res));
  }
}
