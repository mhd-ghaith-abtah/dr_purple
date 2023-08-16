// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_appointments_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAppointmentsAPIResponse _$GetAllAppointmentsAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllAppointmentsAPIResponse(
      result: json['data'] == null
          ? null
          : GetAllAppointmentsAPIResult.fromJson(
              json['data'] as Map<String, dynamic>),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetAllAppointmentsAPIResponseToJson(
        GetAllAppointmentsAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

GetAllAppointmentsAPIResult _$GetAllAppointmentsAPIResultFromJson(
        Map<String, dynamic> json) =>
    GetAllAppointmentsAPIResult(
      appointments: (json['results'] as List<dynamic>?)
          ?.map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllAppointmentsAPIResultToJson(
        GetAllAppointmentsAPIResult instance) =>
    <String, dynamic>{
      'results': instance.appointments,
    };

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as int,
      serviceTime: ServiceTimeModel.fromJson(
          json['serviceTime'] as Map<String, dynamic>),
      dateCreated: json['dateCreated'] as String,
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceTime': instance.serviceTime,
      'dateCreated': instance.dateCreated,
    };

ServiceTimeModel _$ServiceTimeModelFromJson(Map<String, dynamic> json) =>
    ServiceTimeModel(
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      contractService: ContractServiceModel.fromJson(
          json['contractService'] as Map<String, dynamic>),
      state: json['state'] as String,
    );

Map<String, dynamic> _$ServiceTimeModelToJson(ServiceTimeModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'startTime': instance.startTime,
      'contractService': instance.contractService,
      'state': instance.state,
    };

ContractServiceModel _$ContractServiceModelFromJson(
        Map<String, dynamic> json) =>
    ContractServiceModel(
      service: ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
      contract:
          ContractModel.fromJson(json['contract'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractServiceModelToJson(
        ContractServiceModel instance) =>
    <String, dynamic>{
      'contract': instance.contract,
      'service': instance.service,
    };

ContractModel _$ContractModelFromJson(Map<String, dynamic> json) =>
    ContractModel(
      doctor: GetDoctorAPIResult.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractModelToJson(ContractModel instance) =>
    <String, dynamic>{
      'user': instance.doctor,
    };
