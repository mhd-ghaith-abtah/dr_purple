// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_service_time_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllServiceTimeAPIResponse _$GetAllServiceTimeAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllServiceTimeAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetAllServiceTimeAPIResponseToJson(
        GetAllServiceTimeAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
