import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/appointments/domain/entities/book_appointment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_api_response.g.dart';

@JsonSerializable()
class BookAppointmentAPIResponse extends BaseResponseModel {
  BookAppointmentAPIResponse();

  factory BookAppointmentAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookAppointmentAPIResponseToJson(this);

  @override
  BookAppointmentEntity toEntity() => BookAppointmentEntity();
}
