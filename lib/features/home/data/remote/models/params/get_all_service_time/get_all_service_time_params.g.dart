// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_service_time_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllServiceTimeParamsBody _$GetAllServiceTimeParamsBodyFromJson(
        Map<String, dynamic> json) =>
    GetAllServiceTimeParamsBody(
      pageSize: json['PageSize'] as int?,
      pageNo: json['PageNo'] as int?,
      skip: json['Skip'] as int?,
      orderBy: json['OrderBy'] as String?,
      searchBy: json['SearchBy'] as String?,
      isAscending: json['IsAscending'] as bool?,
    );

Map<String, dynamic> _$GetAllServiceTimeParamsBodyToJson(
    GetAllServiceTimeParamsBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PageSize', instance.pageSize);
  writeNotNull('PageNo', instance.pageNo);
  writeNotNull('Skip', instance.skip);
  writeNotNull('OrderBy', instance.orderBy);
  writeNotNull('SearchBy', instance.searchBy);
  writeNotNull('IsAscending', instance.isAscending);
  return val;
}
