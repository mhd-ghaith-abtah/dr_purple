// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordAPIResponse _$ForgetPasswordAPIResponseFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ForgetPasswordAPIResponseToJson(
        ForgetPasswordAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
