import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/cancel_appointment/cancel_appointment_params.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/cancel_appointment_api_response/cancel_appointment_api_response.dart';

abstract class ICancelAppointmentRemoteDataSource extends RemoteDataSource {
  ICancelAppointmentRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<CancelAppointmentAPIResponse> cancelAppointment(
      CancelAppointmentParams cancelAppointmentParams);
}

class CancelAppointmentRemoteDataSource
    extends ICancelAppointmentRemoteDataSource {
  CancelAppointmentRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<CancelAppointmentAPIResponse> cancelAppointment(
      CancelAppointmentParams cancelAppointmentParams) async {
    var res = await cancelAppointmentParams.requestType
        .getHTTPRequestType(this, cancelAppointmentParams);
    return Future.value(CancelAppointmentAPIResponse.fromJson(res));
  }
}
