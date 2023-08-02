// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshAPIResponse _$RefreshAPIResponseFromJson(Map<String, dynamic> json) =>
    RefreshAPIResponse(
      result: json['data'] == null
          ? null
          : RefreshAPIResult.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RefreshAPIResponseToJson(RefreshAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

RefreshAPIResult _$RefreshAPIResultFromJson(Map<String, dynamic> json) =>
    RefreshAPIResult(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$RefreshAPIResultToJson(RefreshAPIResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
