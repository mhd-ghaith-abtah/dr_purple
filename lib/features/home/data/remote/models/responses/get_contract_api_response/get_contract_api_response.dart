import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/home/domain/entities/get_contract_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_contract_api_response.g.dart';

@JsonSerializable()
class GetContractAPIResponse extends BaseResponseModel {
  GetContractAPIResponse();

  factory GetContractAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetContractAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetContractAPIResponseToJson(this);

  @override
  GetContractEntity toEntity() => GetContractEntity();
}
