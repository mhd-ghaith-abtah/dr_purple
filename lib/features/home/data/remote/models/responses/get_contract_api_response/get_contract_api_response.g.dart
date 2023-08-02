// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_contract_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetContractAPIResponse _$GetContractAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetContractAPIResponse()
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetContractAPIResponseToJson(
        GetContractAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
    };
