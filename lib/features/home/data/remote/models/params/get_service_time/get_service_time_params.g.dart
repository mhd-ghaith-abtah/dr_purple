// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_time_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceTimeParamsBody _$GetServiceTimeParamsBodyFromJson(
        Map<String, dynamic> json) =>
    GetServiceTimeParamsBody(
      serviceId: json['ServiceId'] as int?,
    );

Map<String, dynamic> _$GetServiceTimeParamsBodyToJson(
    GetServiceTimeParamsBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ServiceId', instance.serviceId);
  return val;
}
