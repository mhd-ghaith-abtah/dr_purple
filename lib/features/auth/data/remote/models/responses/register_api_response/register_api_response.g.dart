// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAPIResponse _$RegisterAPIResponseFromJson(Map<String, dynamic> json) =>
    RegisterAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RegisterAPIResponseToJson(
        RegisterAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
