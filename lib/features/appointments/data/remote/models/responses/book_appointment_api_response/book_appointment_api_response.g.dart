// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_appointment_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookAppointmentAPIResponse _$BookAppointmentAPIResponseFromJson(
        Map<String, dynamic> json) =>
    BookAppointmentAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BookAppointmentAPIResponseToJson(
        BookAppointmentAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
