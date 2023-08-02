// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_appointment_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppointmentAPIResponse _$GetAppointmentAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetAppointmentAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetAppointmentAPIResponseToJson(
        GetAppointmentAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
