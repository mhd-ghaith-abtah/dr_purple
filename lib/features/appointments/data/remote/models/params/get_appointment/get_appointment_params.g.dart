// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_appointment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAppointmentsTimeParamsBody _$GetAllAppointmentsTimeParamsBodyFromJson(
        Map<String, dynamic> json) =>
    GetAllAppointmentsTimeParamsBody(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$GetAllAppointmentsTimeParamsBodyToJson(
    GetAllAppointmentsTimeParamsBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
