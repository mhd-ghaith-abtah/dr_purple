// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordAPIResponse _$ChangePasswordAPIResponseFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ChangePasswordAPIResponseToJson(
        ChangePasswordAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
