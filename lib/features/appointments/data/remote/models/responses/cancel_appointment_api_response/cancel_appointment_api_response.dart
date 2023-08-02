import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/appointments/domain/entities/cancel_appointment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_appointment_api_response.g.dart';

@JsonSerializable()
class CancelAppointmentAPIResponse extends BaseResponseModel {
  CancelAppointmentAPIResponse();

  factory CancelAppointmentAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelAppointmentAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CancelAppointmentAPIResponseToJson(this);

  @override
  CancelAppointmentEntity toEntity() => CancelAppointmentEntity();
}
