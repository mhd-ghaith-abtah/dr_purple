// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_time_contract_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceTimeContractParamsBody _$GetServiceTimeContractParamsBodyFromJson(
        Map<String, dynamic> json) =>
    GetServiceTimeContractParamsBody(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$GetServiceTimeContractParamsBodyToJson(
    GetServiceTimeContractParamsBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
