import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/appointments/domain/entities/get_all_appointments_entity.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_services_api_response/get_all_services_api_response.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_doctor_api_response/get_doctor_api_response.dart';
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
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "serviceTime")
  final ServiceTimeModel serviceTime;
  @JsonKey(name: "dateCreated")
  final String dateCreated;

  AppointmentModel({
    required this.id,
    required this.serviceTime,
    required this.dateCreated,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}

@JsonSerializable()
class ServiceTimeModel {
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "startTime")
  final String startTime;
  @JsonKey(name: "contractService")
  final ContractServiceModel contractService;
  @JsonKey(name: "state")
  final String state;

  ServiceTimeModel({
    required this.date,
    required this.startTime,
    required this.contractService,
    required this.state,
  });

  factory ServiceTimeModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceTimeModelToJson(this);
}

@JsonSerializable()
class ContractServiceModel {
  @JsonKey(name: "contract")
  final ContractModel contract;
  @JsonKey(name: "service")
  final ServiceModel service;

  ContractServiceModel({
    required this.service,
    required this.contract,
  });

  factory ContractServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ContractServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContractServiceModelToJson(this);
}

@JsonSerializable()
class ContractModel {
  @JsonKey(name: "user")
  final GetDoctorAPIResult doctor;

  ContractModel({
    required this.doctor,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      _$ContractModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContractModelToJson(this);
}
