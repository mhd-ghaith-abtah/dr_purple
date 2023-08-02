// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceParamsBody _$GetServiceParamsBodyFromJson(
        Map<String, dynamic> json) =>
    GetServiceParamsBody(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$GetServiceParamsBodyToJson(
    GetServiceParamsBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
