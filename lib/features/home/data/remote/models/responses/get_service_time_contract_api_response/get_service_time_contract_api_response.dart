import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_time_contract_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_service_time_contract_api_response.g.dart';

@JsonSerializable()
class GetServiceTimeContractAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  GetServiceTimeContractAPIResult? result;

  GetServiceTimeContractAPIResponse({required this.result});

  factory GetServiceTimeContractAPIResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetServiceTimeContractAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$GetServiceTimeContractAPIResponseToJson(this);

  @override
  GetServiceTimeContractEntity toEntity() => GetServiceTimeContractEntity(
        id: result?.id,
        contractId: result?.contractId,
        serviceId: result?.serviceId,
      );
}

@JsonSerializable()
class GetServiceTimeContractAPIResult {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "contractId")
  final int? contractId;
  @JsonKey(name: "serviceId")
  final int? serviceId;

  GetServiceTimeContractAPIResult({
    required this.id,
    required this.contractId,
    required this.serviceId,
  });

  factory GetServiceTimeContractAPIResult.fromJson(Map<String, dynamic> json) =>
      _$GetServiceTimeContractAPIResultFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetServiceTimeContractAPIResultToJson(this);
}
