// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_account_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAccountAPIResponse _$VerifyAccountAPIResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyAccountAPIResponse(
      result: json['data'] == null
          ? null
          : VerifyAccountAPIResult.fromJson(
              json['data'] as Map<String, dynamic>),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VerifyAccountAPIResponseToJson(
        VerifyAccountAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

VerifyAccountAPIResult _$VerifyAccountAPIResultFromJson(
        Map<String, dynamic> json) =>
    VerifyAccountAPIResult(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$VerifyAccountAPIResultToJson(
        VerifyAccountAPIResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
