// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_language_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeLanguageAPIResponse _$ChangeLanguageAPIResponseFromJson(
        Map<String, dynamic> json) =>
    ChangeLanguageAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ChangeLanguageAPIResponseToJson(
        ChangeLanguageAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
