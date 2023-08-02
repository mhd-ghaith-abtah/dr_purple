// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAPIResponse _$LoginAPIResponseFromJson(Map<String, dynamic> json) =>
    LoginAPIResponse(
      result: json['data'] == null
          ? null
          : LoginAPIResult.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$LoginAPIResponseToJson(LoginAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

LoginAPIResult _$LoginAPIResultFromJson(Map<String, dynamic> json) =>
    LoginAPIResult(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$LoginAPIResultToJson(LoginAPIResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
