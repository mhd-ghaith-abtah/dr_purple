import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/appointments/data/remote/models/params/book_appointment/book_appointment_params.dart';
import 'package:dr_purple/features/appointments/data/remote/models/responses/book_appointment_api_response/book_appointment_api_response.dart';

abstract class IBookAppointmentRemoteDataSource extends RemoteDataSource {
  IBookAppointmentRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<BookAppointmentAPIResponse> bookAppointment(
      BookAppointmentParams bookAppointmentParams);
}

class BookAppointmentRemoteDataSource extends IBookAppointmentRemoteDataSource {
  BookAppointmentRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<BookAppointmentAPIResponse> bookAppointment(
      BookAppointmentParams bookAppointmentParams) async {
    var res = await bookAppointmentParams.requestType
        .getHTTPRequestType(this, bookAppointmentParams);
    return Future.value(BookAppointmentAPIResponse.fromJson(res));
  }
}
