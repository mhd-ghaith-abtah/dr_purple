// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_fcm_token_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateFCMTokenAPIResponse _$UpdateFCMTokenAPIResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateFCMTokenAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$UpdateFCMTokenAPIResponseToJson(
        UpdateFCMTokenAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
