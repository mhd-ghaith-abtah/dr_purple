// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_appointment_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelAppointmentAPIResponse _$CancelAppointmentAPIResponseFromJson(
        Map<String, dynamic> json) =>
    CancelAppointmentAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CancelAppointmentAPIResponseToJson(
        CancelAppointmentAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
