// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_contract_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetContractParamsBody _$GetContractParamsBodyFromJson(
        Map<String, dynamic> json) =>
    GetContractParamsBody(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$GetContractParamsBodyToJson(
    GetContractParamsBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
