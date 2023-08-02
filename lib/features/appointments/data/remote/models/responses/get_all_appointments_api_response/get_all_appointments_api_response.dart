import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_all_appointments_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_appointments_api_response.g.dart';

@JsonSerializable()
class GetAllAppointmentsAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  GetAllAppointmentsAPIResult? result;

  GetAllAppointmentsAPIResponse({required this.result});

  factory GetAllAppointmentsAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllAppointmentsAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAllAppointmentsAPIResponseToJson(this);

  @override
  GetAllAppointmentsEntity toEntity() =>
      GetAllAppointmentsEntity(appointments: result?.appointments);
}

@JsonSerializable()
class GetAllAppointmentsAPIResult {
  @JsonKey(name: "results")
  final List<AppointmentModel>? appointments;

  GetAllAppointmentsAPIResult({required this.appointments});

  factory GetAllAppointmentsAPIResult.fromJson(Map<String, dynamic> json) =>
      _$GetAllAppointmentsAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllAppointmentsAPIResultToJson(this);
}

@JsonSerializable()
class AppointmentModel {
  @JsonKey(name: "serviceTimeId")
  final int serviceTimeId;

  AppointmentModel({required this.serviceTimeId});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}
