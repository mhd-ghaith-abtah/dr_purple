// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceAPIResponse _$GetServiceAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetServiceAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetServiceAPIResponseToJson(
        GetServiceAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
