// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_doctor_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDoctorParamsBody _$GetDoctorParamsBodyFromJson(Map<String, dynamic> json) =>
    GetDoctorParamsBody(
      contractServiceId: json['contractServiceId'] as int?,
    );

Map<String, dynamic> _$GetDoctorParamsBodyToJson(GetDoctorParamsBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contractServiceId', instance.contractServiceId);
  return val;
}
