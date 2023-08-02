import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_appointment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_appointment_api_response.g.dart';

@JsonSerializable()
class GetAppointmentAPIResponse extends BaseResponseModel {
  GetAppointmentAPIResponse();

  factory GetAppointmentAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAppointmentAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAppointmentAPIResponseToJson(this);

  @override
  GetAppointmentEntity toEntity() => GetAppointmentEntity();
}
