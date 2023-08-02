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
      serviceTimeId: json['serviceTimeId'] as int,
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'serviceTimeId': instance.serviceTimeId,
    };
