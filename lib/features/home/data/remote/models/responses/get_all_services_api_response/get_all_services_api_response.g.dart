// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_services_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllServicesAPIResponse _$GetAllServicesAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllServicesAPIResponse(
      result: json['data'] == null
          ? null
          : GetAllServicesAPIResult.fromJson(
              json['data'] as Map<String, dynamic>),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetAllServicesAPIResponseToJson(
        GetAllServicesAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

GetAllServicesAPIResult _$GetAllServicesAPIResultFromJson(
        Map<String, dynamic> json) =>
    GetAllServicesAPIResult(
      services: (json['results'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['currentPage'] as int?,
      pageCount: json['pageCount'] as int?,
      pageSize: json['pageSize'] as int?,
      rowCount: json['rowCount'] as int?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
    );

Map<String, dynamic> _$GetAllServicesAPIResultToJson(
        GetAllServicesAPIResult instance) =>
    <String, dynamic>{
      'results': instance.services,
      'currentPage': instance.currentPage,
      'pageCount': instance.pageCount,
      'pageSize': instance.pageSize,
      'rowCount': instance.rowCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: json['id'] as int?,
      subDepartmentId: json['subDepartmentId'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      duration: json['duration'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subDepartmentId': instance.subDepartmentId,
      'name': instance.name,
      'price': instance.price,
      'duration': instance.duration,
      'description': instance.description,
    };
