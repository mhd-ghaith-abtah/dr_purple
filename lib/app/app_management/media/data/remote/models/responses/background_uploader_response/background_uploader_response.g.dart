// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_uploader_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackgroundUploaderResponse _$BackgroundUploaderResponseFromJson(
        Map<String, dynamic> json) =>
    BackgroundUploaderResponse(
      taskId: json['taskId'] as String?,
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BackgroundUploaderResponseToJson(
        BackgroundUploaderResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'taskId': instance.taskId,
    };
