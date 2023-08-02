// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_time_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceTimeAPIResponse _$GetServiceTimeAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetServiceTimeAPIResponse(
      result: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              GetServiceTimeAPIResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetServiceTimeAPIResponseToJson(
        GetServiceTimeAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

GetServiceTimeAPIResult _$GetServiceTimeAPIResultFromJson(
        Map<String, dynamic> json) =>
    GetServiceTimeAPIResult(
      id: json['id'] as int?,
      serviceId: json['serviceId'] as int?,
      contractServiceId: json['contractServiceId'] as int?,
      date: json['date'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$GetServiceTimeAPIResultToJson(
        GetServiceTimeAPIResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceId': instance.serviceId,
      'contractServiceId': instance.contractServiceId,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'state': instance.state,
    };
