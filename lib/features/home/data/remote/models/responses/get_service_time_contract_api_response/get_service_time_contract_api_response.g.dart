// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_time_contract_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceTimeContractAPIResponse _$GetServiceTimeContractAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetServiceTimeContractAPIResponse(
      result: json['data'] == null
          ? null
          : GetServiceTimeContractAPIResult.fromJson(
              json['data'] as Map<String, dynamic>),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetServiceTimeContractAPIResponseToJson(
        GetServiceTimeContractAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

GetServiceTimeContractAPIResult _$GetServiceTimeContractAPIResultFromJson(
        Map<String, dynamic> json) =>
    GetServiceTimeContractAPIResult(
      id: json['id'] as int?,
      contractId: json['contractId'] as int?,
      serviceId: json['serviceId'] as int?,
    );

Map<String, dynamic> _$GetServiceTimeContractAPIResultToJson(
        GetServiceTimeContractAPIResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractId': instance.contractId,
      'serviceId': instance.serviceId,
    };
