import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_services_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_services_api_response.g.dart';

@JsonSerializable()
class GetAllServicesAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  GetAllServicesAPIResult? result;

  GetAllServicesAPIResponse({required this.result});

  factory GetAllServicesAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllServicesAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAllServicesAPIResponseToJson(this);

  @override
  GetAllServicesEntity toEntity() => GetAllServicesEntity(
        services: result?.services,
        currentPage: result?.currentPage,
        pageCount: result?.pageCount,
        pageSize: result?.pageSize,
        rowCount: result?.rowCount,
        hasPreviousPage: result?.hasPreviousPage,
        hasNextPage: result?.hasNextPage,
      );
}

@JsonSerializable()
class GetAllServicesAPIResult {
  @JsonKey(name: "results")
  final List<ServiceModel>? services;
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "pageCount")
  final int? pageCount;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "rowCount")
  final int? rowCount;
  @JsonKey(name: "hasPreviousPage")
  final bool? hasPreviousPage;
  @JsonKey(name: "hasNextPage")
  final bool? hasNextPage;

  GetAllServicesAPIResult({
    required this.services,
    required this.currentPage,
    required this.pageCount,
    required this.pageSize,
    required this.rowCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory GetAllServicesAPIResult.fromJson(Map<String, dynamic> json) =>
      _$GetAllServicesAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllServicesAPIResultToJson(this);
}

@JsonSerializable()
class ServiceModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "subDepartmentId")
  final int? subDepartmentId;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "duration")
  final String? duration;
  @JsonKey(name: "description")
  final String? description;

  ServiceModel({
    required this.id,
    required this.subDepartmentId,
    required this.name,
    required this.price,
    required this.duration,
    required this.description,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
