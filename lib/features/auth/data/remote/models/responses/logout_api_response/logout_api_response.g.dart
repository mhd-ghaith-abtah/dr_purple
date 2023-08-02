// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutAPIResponse _$LogoutAPIResponseFromJson(Map<String, dynamic> json) =>
    LogoutAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$LogoutAPIResponseToJson(LogoutAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
