// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileAPIResponse _$UpdateProfileAPIResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$UpdateProfileAPIResponseToJson(
        UpdateProfileAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
