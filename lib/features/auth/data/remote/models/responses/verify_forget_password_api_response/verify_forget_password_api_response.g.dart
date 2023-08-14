// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_forget_password_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyForgetPasswordAPIResponse _$VerifyForgetPasswordAPIResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyForgetPasswordAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VerifyForgetPasswordAPIResponseToJson(
        VerifyForgetPasswordAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
